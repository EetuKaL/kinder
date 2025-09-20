package fb

import (
	"context"
	"fmt"
	"time"

	"golang.org/x/oauth2/google"
	"google.golang.org/api/cloudbilling/v1"
	crmv1 "google.golang.org/api/cloudresourcemanager/v1"
	"google.golang.org/api/iam/v1"
	"google.golang.org/api/option"
	"google.golang.org/api/serviceusage/v1"
)

func serviceAccountExists(svc *iam.Service, project string) (string, error) {
	getServiceAccounts, err := svc.Projects.ServiceAccounts.List(fmt.Sprintf("projects/%s", project)).Do()

	fmt.Println("Checking if service account exists for project:", project)
	if err != nil {
		return "", err
	}
	email := ""
	for _, sa := range getServiceAccounts.Accounts {

		if sa.ProjectId == project {
			fmt.Println("Service account already exists:", sa.Email)
			email = sa.Email
			break
		}
	}
	return email, nil
}

// linkBilling attaches a billing account to the project
func linkBilling(ctx context.Context, creds *google.Credentials, project, fbBillingAccount string) error {
	svc, err := cloudbilling.NewService(ctx, option.WithCredentials(creds))
	if err != nil {
		return err
	}

	fmt.Printf("Linking billing account %s to project %s\n", fbBillingAccount, project)

	req := &cloudbilling.ProjectBillingInfo{
		ProjectId:          project,
		BillingAccountName: fbBillingAccount,
	}
	_, err = svc.Projects.UpdateBillingInfo("projects/"+project, req).Do()
	if err != nil {
		return fmt.Errorf("failed to link billing account: %w", err)
	}
	fmt.Println("Billing linked to project:", fbBillingAccount)
	return nil
}

// enableAPIs enables a list of APIs for the project
func enableAPIs(ctx context.Context, creds *google.Credentials, project string, apis []string) error {
	svc, err := serviceusage.NewService(ctx, option.WithCredentials(creds))
	if err != nil {
		return err
	}
	for _, a := range apis {
		name := fmt.Sprintf("projects/%s/services/%s", project, a)
		_, err := svc.Services.Enable(name, &serviceusage.EnableServiceRequest{}).Do()
		if err != nil {
			return fmt.Errorf("enable %s: %w", a, err)
		}
		// small delay to apis to enable properly
		time.Sleep(2 * time.Second)
	}
	fmt.Println("APIs enabled:", apis)

	return nil
}

func projectExists(service *crmv1.Service, project string) (bool, error) {
	getProjects, err := service.Projects.List().Do()
	if err != nil {
		return false, fmt.Errorf("failed to list projects: %v", err)
	}
	projectExisting := false
	for _, p := range getProjects.Projects {
		if p.ProjectId == project {
			fmt.Println("Existing project:", p.ProjectId, p.Name)
			projectExisting = true
		}
	}

	return projectExisting, nil
}
