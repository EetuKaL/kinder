package aws

import (
	"context"
	"fmt"
	"os"
	"stack/pkg/projectcfg"

	"github.com/aws/aws-cdk-go/awscdk/v2"
	"github.com/aws/aws-cdk-go/awscdk/v2/awsiam"
	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/cloudformation"
	"github.com/aws/aws-sdk-go-v2/service/secretsmanager/types"
	"github.com/aws/jsii-runtime-go"
)

type awsController struct {
	app          awscdk.App
	stack        awscdk.Stack
	region       string
	cfg          aws.Config
	cfn          *cloudformation.Client
	project      string
	templatePath string
	templateName string
	stackName    string
}

// Create new AWS controller
func NewAWSController(projectCfg projectcfg.ProjectConfig) (awsController, error) {
	c := awsController{}
	c.region = projectCfg.AWSRegion
	c.project = projectCfg.ID
	c.stackName = projectCfg.ID + "-stack"
	c.templateName = projectCfg.ID + ".template.json"
	c.templatePath = "./pkg/aws/cdk.out"
	app := awscdk.NewApp(&awscdk.AppProps{
		Outdir: jsii.String(c.templatePath),
	})
	c.app = app

	stack := awscdk.NewStack(app, jsii.String(projectCfg.ID), &awscdk.StackProps{
		Env: &awscdk.Environment{
			Region:  jsii.String(c.region),
			Account: &projectCfg.AWSIdentity,
		},
	})
	c.stack = stack

	cfg, err := config.LoadDefaultConfig(context.TODO(),
		config.WithRegion(projectCfg.AWSRegion),
	)
	c.cfg = cfg

	if err != nil {
		return awsController{}, fmt.Errorf("failed to load AWS config: %w", err)
	}

	cfn := cloudformation.NewFromConfig(c.cfg)
	c.cfn = cfn

	return c, nil
}

// Get all secrets
func (c awsController) GetSecretsEntries() ([]types.SecretListEntry, error) {
	return getSecretEntries(c.cfg)
}

// Get secret by name and return secret string
func (c awsController) GetSecret(name string) (string, error) {
	return getSecret(c.cfg, name)
}

// Create secret and return ARN
func (c awsController) CreateSecret(name, secret, description string) (string, error) {
	return createSecret(c.cfg, c.region, c.project, name, description, secret)
}

// Create bucket and return ARN
func (c awsController) CreateBucket(name string) (string, error) {
	return createBucket(c.stack, c.project, name)
}

// Create policy with granted ARNs and return policy
func (c awsController) CreatePolicy(grantedArns []string) awsiam.Policy {
	return createPolicy(c.stack, c.project, grantedArns)
}

// Create named role and return role
func (c awsController) CreateRole(name string) (awsiam.Role, error) {
	return createRole(c.stack, name, c.project, c.region)
}

// Create lambda with URL and return URL
func (c awsController) CreateLambdaWithUrl(name, codeAt, roleArn string, authCredentials string) (string, error) {
	return createLambdaWithUrl(c.stack, name, codeAt, c.project, roleArn, authCredentials)
}

// Create CloudFormation template
func (c awsController) CreateTemplate() {
	os.Remove(c.templatePath)
	c.app.Synth(nil)
}

// Deploy stack
func (c awsController) Deploy() error {
	return deploy(c.cfn, c.templatePath, c.templateName, c.stackName, c.project)
}
