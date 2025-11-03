package fb

import (
	"context"
	"encoding/base64"
	"fmt"
	"net/http"
	"stack/pkg/commands"

	billing "cloud.google.com/go/billing/apiv1"
	"cloud.google.com/go/billing/apiv1/billingpb"
	admin "cloud.google.com/go/iam/admin/apiv1"
	"cloud.google.com/go/iam/admin/apiv1/adminpb"
	"golang.org/x/oauth2/google"
	crmv1 "google.golang.org/api/cloudresourcemanager/v1"
	"google.golang.org/api/googleapi"
	"google.golang.org/api/iam/v1"
	"google.golang.org/api/option"
)

func createProject(ctx context.Context, creds *google.Credentials, projectName, project, fbBillingAccount string) error {

	svc, err := crmv1.NewService(ctx, option.WithCredentials(creds))
	if err != nil {
		return err
	}

	proj := &crmv1.Project{
		ProjectId: project,
		Name:      projectName,
	}

	_, err = svc.Projects.Create(proj).Do()
	if err != nil {
		return err
	}
	if err := linkBilling(ctx, creds, project, fbBillingAccount); err != nil {
		return fmt.Errorf("failed to link billing to project: %v", err)
	}

	apis := []string{
		"iam.googleapis.com",
		"sqladmin.googleapis.com",
		"secretmanager.googleapis.com",
		"cloudresourcemanager.googleapis.com",
		"firestore.googleapis.com",
	}
	if err := enableAPIs(ctx, creds, project, apis); err != nil {
		return fmt.Errorf("failed to enable APIs: %v", err)
	}

	return nil
}

func firestoreExists(project string) (bool, error) {
	return commands.RunFirestoreExists(project)
}
func getFirestoreRulesTemplate() string {
	return `
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {	
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
`
}

func getBillingAccount(ctx context.Context) (string, error) {
	client, err := billing.NewCloudBillingClient(ctx)
	if err != nil {
		return "", err
	}
	defer client.Close()

	req := &billingpb.ListBillingAccountsRequest{}
	it := client.ListBillingAccounts(ctx, req)
	var account string

	for {
		acct, err := it.Next()
		if err != nil {
			break
		}
		if acct.Open {
			account = acct.Name
			fmt.Println("Using billing account:", account)
			break
		}
	}
	if account == "" {
		return "", fmt.Errorf("no open billing account found")
	}
	return account, nil
}

func createFirestore(ctx context.Context, rules, project, fbRegion string) error {
	if created, err := commands.RunCreateFirestore(project, fbRegion); err != nil || !created {
		return fmt.Errorf("failed to create Firestore database: %v", err)
	}

	err := commands.RunSetFirestoreRules(rules)
	if err != nil {
		return fmt.Errorf("failed to deploy Firestore rules: %v", err)
	}
	return nil
}

func getServiceAccountKeys(svc *iam.Service, saEmail, project string) ([]*iam.ServiceAccountKey, error) {
	name := fmt.Sprintf("projects/%s/serviceAccounts/%s", project, saEmail)
	response, err := svc.Projects.ServiceAccounts.Keys.List(name).Do()
	if err != nil {
		if gerr, ok := err.(*googleapi.Error); ok && gerr.Code == http.StatusNotFound {
			fmt.Printf("got error: %v\n", gerr)
			return nil, nil
		}
		fmt.Printf("got error: %v\n", err)
		return nil, err
	}
	if len(response.Keys) == 0 {
		fmt.Printf("no keys found for service account: %s\n", saEmail)
		return nil, nil
	}
	fmt.Printf("found %d keys for service account: %s\n", len(response.Keys), saEmail)
	// Get the first key
	return response.Keys, nil
}

// createServiceAccountKey creates a key for a service account and returns the JSON key bytes
func createServiceAccountKey(svc *iam.Service, saEmail, project string) (string, []byte, error) {
	name := fmt.Sprintf("projects/%s/serviceAccounts/%s", project, saEmail)

	req := &iam.CreateServiceAccountKeyRequest{
		PrivateKeyType: "TYPE_GOOGLE_CREDENTIALS_FILE",
	}
	key, err := svc.Projects.ServiceAccounts.Keys.Create(name, req).Do()
	if err != nil {
		return "", nil, err
	}
	decoded, err := base64.StdEncoding.DecodeString(key.PrivateKeyData)
	if err != nil {
		return "", nil, err
	}
	return key.Name, decoded, nil
}

func createServiceAccount(ctx context.Context, project string) (string, error) {
	adminClient, err := admin.NewIamClient(ctx)
	if err != nil {
		return "", fmt.Errorf("failed to create IAM client: %v", err)
	}
	defer adminClient.Close()
	req := &adminpb.CreateServiceAccountRequest{
		Name:      fmt.Sprintf("projects/%s", project),
		AccountId: project,
		ServiceAccount: &adminpb.ServiceAccount{
			DisplayName: "",
		},
	}

	sa, err := adminClient.CreateServiceAccount(ctx, req)
	if err != nil {
		return "", fmt.Errorf("failed to create service account: %v", err)
	}

	fmt.Println("Created service account:", sa.Email)
	return sa.Email, nil
}
