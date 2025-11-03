package fb

import (
	"context"
	"fmt"
	"stack/pkg/projectcfg"

	"golang.org/x/oauth2/google"
	"google.golang.org/api/cloudbilling/v1"
	crmv1 "google.golang.org/api/cloudresourcemanager/v1"
	"google.golang.org/api/iam/v1"
	"google.golang.org/api/option"
)

type gcController struct {
	projectID string
	fBRegion  string
	ctx       context.Context
	creds     *google.Credentials
	service   *crmv1.Service
	svc       *iam.Service
}

func NewGoogleCloudController(config projectcfg.ProjectConfig) (gcController, error) {
	var c gcController

	c.projectID = config.ID
	c.fBRegion = config.FBRegion

	c.ctx = context.Background()

	// Get credentials
	creds, err := google.FindDefaultCredentials(c.ctx,
		cloudbilling.CloudPlatformScope,
	)
	if err != nil {
		return c, fmt.Errorf("failed to get ADC credentials: %v", err)
	}
	c.creds = creds

	// Create Google Cloud Resource Manager service
	service, err := crmv1.NewService(c.ctx)
	if err != nil {
		return c, fmt.Errorf("failed to create cloudresourcemanager service: %v", err)
	}
	c.service = service

	// Create IAM service
	svc, err := iam.NewService(c.ctx, option.WithCredentials(c.creds))
	if err != nil {
		return c, fmt.Errorf("failed to create iam service: %v", err)
	}
	c.svc = svc

	// Check if project exists
	exists, err := c.checkProjectExists()
	if err != nil {
		return c, err
	}
	if exists {
		fmt.Printf("Project already exists, skip project creation.")
	} else {
		// Get billing account
		acc, err := getBillingAccount(c.ctx)
		if err != nil {
			return c, err
		}
		// Create project
		err = c.createProject(acc)
		if err != nil {
			return c, err
		}
	}

	return c, nil
}

func (c gcController) checkProjectExists() (bool, error) {
	return projectExists(c.service, c.projectID)
}

func (c gcController) createProject(fbBillingAccount string) error {

	return createProject(c.ctx, c.creds, c.projectID, c.projectID, fbBillingAccount)
}

func (c gcController) CheckFirestoreExists() (bool, error) {
	return firestoreExists(c.projectID)
}

func (c gcController) CreateFirestore(rules string) error {
	return createFirestore(c.ctx, rules, c.projectID, c.fBRegion)
}

func (c gcController) GetFirestoreRules() string {
	return getFirestoreRulesTemplate()
}

func (c gcController) CheckServiceAccountExists() (string, error) {
	return serviceAccountExists(c.svc, c.projectID)
}

func (c gcController) CreateServiceAccount() (string, error) {
	return createServiceAccount(c.ctx, c.projectID)
}

func (c gcController) GetServiceAccountKeys(saEmail string) ([]*iam.ServiceAccountKey, error) {
	return getServiceAccountKeys(c.svc, saEmail, c.projectID)
}

func (c gcController) CreateServiceAccountKey(saEmail string) (string, []byte, error) {
	return createServiceAccountKey(c.svc, saEmail, c.projectID)
}
