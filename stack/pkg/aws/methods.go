package aws

import (
	"context"
	"errors"
	"fmt"
	"os"
	"stack/pkg/commands"
	"stack/pkg/lambda_builder"
	"strings"

	"github.com/aws/aws-cdk-go/awscdk/v2"
	"github.com/aws/aws-cdk-go/awscdk/v2/awsiam"
	"github.com/aws/aws-cdk-go/awscdk/v2/awslambda"
	"github.com/aws/aws-cdk-go/awscdk/v2/awss3"
	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/cloudformation"
	cloudformationtypes "github.com/aws/aws-sdk-go-v2/service/cloudformation/types"
	"github.com/aws/aws-sdk-go-v2/service/secretsmanager"
	"github.com/aws/aws-sdk-go-v2/service/secretsmanager/types"
	"github.com/aws/jsii-runtime-go"
	"github.com/aws/smithy-go"
)

func getSecretEntries(config aws.Config) ([]types.SecretListEntry, error) {
	sm := secretsmanager.NewFromConfig(config)
	input := &secretsmanager.ListSecretsInput{}
	output, err := sm.ListSecrets(context.TODO(), input)
	if err != nil {
		return nil, fmt.Errorf("error listing secrets: %w", err)
	}
	return output.SecretList, nil
}

func getSecret(config aws.Config, name string) (string, error) {
	sm := secretsmanager.NewFromConfig(config)
	input := &secretsmanager.GetSecretValueInput{
		SecretId: aws.String(name),
	}
	output, err := sm.GetSecretValue(context.TODO(), input)
	if err != nil {
		return "", fmt.Errorf("error getting secret: %w", err)
	}
	return *output.SecretString, nil
}

func createSecret(config aws.Config, region, project, name, desc, authCredentials string,
) (string, error) {
	sm := secretsmanager.NewFromConfig(config)

	secretInput := &secretsmanager.CreateSecretInput{
		Name:         aws.String(name),
		Description:  aws.String("Secrets for project: " + project + ": " + desc),
		SecretString: aws.String(authCredentials),
	}

	secret, err := sm.CreateSecret(context.TODO(), secretInput)
	if err != nil {
		return "", fmt.Errorf("error creating secret: %w", err)
	}

	return *secret.ARN, nil
}

func createBucket(stack awscdk.Stack, project, name string) (string, error) {
	bucket := awss3.NewBucket(stack, jsii.String(fmt.Sprintf("bucket-%s-%s", project, name)), &awss3.BucketProps{
		RemovalPolicy:     awscdk.RemovalPolicy_DESTROY,
		AutoDeleteObjects: jsii.Bool(true),
		BucketName:        jsii.String(name),
	})

	if bucket.BucketArn() == nil || *bucket.BucketArn() == "" {
		return "", fmt.Errorf("error creating s3 bucket")
	}
	return *bucket.BucketArn(), nil
}

func createLambdaWithUrl(stack awscdk.Stack, lambdaName, path, project, roleArn string, authCredentials string) (string, error) {
	zipped, err := lambda_builder.BuildAndZip(path, []byte(authCredentials))
	if err != nil {
		return "", fmt.Errorf("error building and zipping lambda: %v", err)
	}
	name := fmt.Sprintf("%s-%s", project, lambdaName)

	backend := awslambda.NewFunction(stack, jsii.String(name), &awslambda.FunctionProps{
		Runtime: awslambda.Runtime_PROVIDED_AL2023(),
		Handler: jsii.String("index.handler"),
		Code:    awslambda.AssetCode_FromAsset(jsii.String(zipped), nil),
		Role:    awsiam.Role_FromRoleArn(stack, jsii.String("LambdaExecutionRole"), &roleArn, nil),
	})

	if backend.FunctionArn() == nil || *backend.FunctionArn() == "" {
		return "", fmt.Errorf("error creating lambda function")
	}

	url := backend.AddFunctionUrl(&awslambda.FunctionUrlOptions{
		AuthType: awslambda.FunctionUrlAuthType_NONE,
	})

	if url.Url() == nil || *url.Url() == "" {
		return "", fmt.Errorf("error creating lambda function url")
	}

	awscdk.NewCfnOutput(stack, jsii.String(fmt.Sprintf("%s-url", name)), &awscdk.CfnOutputProps{
		Value: url.Url(),
	})

	return *url.PhysicalName(), nil
}

func createRole(stack awscdk.Stack, name, project, region string) (awsiam.Role, error) {
	role := awsiam.NewRole(stack, jsii.String(fmt.Sprintf("%s-%s-role", project, name)), &awsiam.RoleProps{
		AssumedBy: awsiam.NewServicePrincipal(jsii.String("lambda.amazonaws.com"), &awsiam.ServicePrincipalOpts{
			Region: jsii.String(region),
		}),
	})

	if role.RoleArn() == nil || *role.RoleArn() == "" {
		return nil, fmt.Errorf("error creating iam role")
	}

	return role, nil

}

func createPolicy(stack awscdk.Stack, project string, secretArns []string) awsiam.Policy {
	policy := awsiam.NewPolicy(stack, jsii.String(fmt.Sprintf("%s-policy", project)), &awsiam.PolicyProps{
		Statements: &[]awsiam.PolicyStatement{
			awsiam.NewPolicyStatement(&awsiam.PolicyStatementProps{
				Actions:   jsii.Strings("*"),
				Resources: jsii.Strings(secretArns...),
			}),
		},
	})

	return policy
}

func stackExists(ctx context.Context, cfn *cloudformation.Client, stackName string) (bool, error) {
	_, err := cfn.DescribeStacks(ctx, &cloudformation.DescribeStacksInput{
		StackName: &stackName,
	})
	if err != nil {
		var apiErr smithy.APIError
		if errors.As(err, &apiErr) &&
			apiErr.ErrorCode() == "ValidationError" &&
			strings.Contains(apiErr.ErrorMessage(), "does not exist") {
			return false, nil
		}
		return false, fmt.Errorf("describe stacks: %w", err)
	}
	return true, nil
}

func deploy(cloudformationClient *cloudformation.Client, templatePath, templateName, stackName, projectId string) error {
	err := commands.RunPublishCDKAssets(templatePath, projectId)
	if err != nil {
		return fmt.Errorf("failed to publish cdk assets: %w", err)
	}

	templateBody, err := os.ReadFile(templatePath + "/" + templateName)
	if err != nil {
		return fmt.Errorf("failed to read template file: %w", err)
	}

	stackExists, err := stackExists(context.TODO(), cloudformationClient, stackName)
	if err != nil {
		return fmt.Errorf("failed to check if stack exists: %w", err)
	}

	if stackExists {
		_, err = cloudformationClient.UpdateStack(context.TODO(), &cloudformation.UpdateStackInput{
			StackName:    &stackName,
			TemplateBody: aws.String(string(templateBody)),
			Capabilities: []cloudformationtypes.Capability{cloudformationtypes.CapabilityCapabilityIam},
		})
	} else {
		_, err = cloudformationClient.CreateStack(context.TODO(), &cloudformation.CreateStackInput{
			StackName:    &stackName,
			TemplateBody: aws.String(string(templateBody)),
			Capabilities: []cloudformationtypes.Capability{cloudformationtypes.CapabilityCapabilityIam},
		})
	}

	if err != nil {
		return fmt.Errorf("failed to create stack: %w", err)
	}

	fmt.Println("Stack creation started, you can check the status in the AWS console.")
	return nil
}
