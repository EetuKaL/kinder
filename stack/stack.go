package main

import (
	"fmt"
	"log"
	"stack/pkg/aws"
	"stack/pkg/commands"
	"stack/pkg/fb"
	"stack/pkg/projectcfg"
	"strings"

	"github.com/aws/aws-sdk-go-v2/service/secretsmanager/types"
)

func main() {

	config, err := configure()
	if err != nil {
		log.Fatal(err)
	}

	gcController, err := fb.NewGoogleCloudController(*config)
	if err != nil {
		log.Fatal(err)
	}

	awsController, err := aws.NewAWSController(*config)
	if err != nil {
		log.Fatal(err)
	}

	exists, err := gcController.CheckFirestoreExists()
	if err != nil {
		log.Fatal(err)
	}

	if !exists {
		firestoreRules := gcController.GetFirestoreRules()

		err = gcController.CreateFirestore(firestoreRules)
		if err != nil {
			log.Fatal(err)
		}
	}

	googleServiceAccountEmail, err := gcController.CheckServiceAccountExists()
	if err != nil {
		log.Fatal(err)
	}

	if googleServiceAccountEmail == "" {
		googleServiceAccountEmail, err = gcController.CreateServiceAccount()
		if err != nil || googleServiceAccountEmail == "" {
			log.Fatalf("Failed to create service account: %v", err)
		}
	}
	var secretString string
	var secretArn string
	foundKeys, err := gcController.GetServiceAccountKeys(googleServiceAccountEmail)
	if err != nil {
		log.Fatal(err)
	}
	if len(foundKeys) == 0 {
		fmt.Printf("No service account keys found for: %s - so creating a new key\n", googleServiceAccountEmail)
		// Create service Account Key
		accountKeyName, authCredentials, err := gcController.CreateServiceAccountKey(googleServiceAccountEmail)
		if err != nil {
			log.Fatal(err)
		}
		secretString = string(authCredentials)

		key, err := keyFromKeyName(accountKeyName)
		if err != nil {
			log.Fatal(err)
		}

		secretArn, err = awsController.CreateSecret(key, secretString, "")
		if err != nil {
			log.Fatal(err)
		}
	} else {
		fmt.Printf("Service account keys found for: %s\n", googleServiceAccountEmail)
		secrets, err := awsController.GetSecretsEntries()
		if err != nil {
			log.Fatal(err)
		}

		var secret *types.SecretListEntry

		for _, keyEntry := range foundKeys {
			key, err := keyFromKeyName(keyEntry.Name)
			if err != nil {
				log.Fatal(err)
			}
			for _, s := range secrets {
				if *s.Name == key {
					fmt.Printf("Found credentials from secrcretsManager\n")
					secret = &s
					break
				}
			}
		}
		if secret == nil {
			fmt.Printf("No matching secret found for service account keys, creating new key and secret.\n")
			// Create service Account Key
			accountKeyName, authCredentials, err := gcController.CreateServiceAccountKey(googleServiceAccountEmail)
			if err != nil {
				log.Fatal(err)
			}
			secretString = string(authCredentials)
			key, err := keyFromKeyName(accountKeyName)
			if err != nil {
				log.Fatal(err)
			}
			secretArn, err = awsController.CreateSecret(key, secretString, "")
			if err != nil {
				log.Fatal(err)
			}
		} else {
			fmt.Printf("Trying to get credentials from secretsmanager\n")
			secretString, err = awsController.GetSecret(*secret.Name)
			if err != nil {
				log.Fatal(err)
			}
			secretArn = *secret.ARN
		}
	}

	fmt.Printf("Successfully retrieved Credentials.\n")

	bucketName := fmt.Sprintf("%s-bucket", config.ID)

	bucketArn, err := awsController.CreateBucket(bucketName)

	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("Bucket Created: %s\n", bucketName)

	policy := awsController.CreatePolicy([]string{secretArn, bucketArn})

	lambdaName := fmt.Sprintf("%s-lambda", config.ID)

	lambdaRole, err := awsController.CreateRole(fmt.Sprintf("%s-role", lambdaName))
	if err != nil {
		log.Fatal(err)
	}

	lambdaRole.AttachInlinePolicy(policy)

	url, err := awsController.CreateLambdaWithUrl(lambdaName, config.LambdaLocation, *lambdaRole.RoleArn(), secretString)

	if err != nil {
		log.Fatal(err)
	}

	fmt.Printf("Lambda Created with URL: %s\n", url)

	fmt.Println("next Synth & Deploy:")

	awsController.CreateTemplate()

	fmt.Printf("Synthed.\n")

	err = awsController.Deploy()
	if err != nil {
		log.Fatal(err)
	}

	fmt.Println("Stack synthesized and deployed successfully.")

}

func configure() (*projectcfg.ProjectConfig, error) {
	awsIdentity, err := commands.RunGetAwsIdentity()
	if err != nil {
		log.Fatal(err)
	}
	awsRegion, err := commands.RunGetAwsRegion()
	if err != nil {
		log.Fatal(err)
	}

	fbRegion := "europe-west1"
	projectId := "28092025"
	projectName := "kinder"

	config, err := projectcfg.NewProjectConfig(projectId, projectName, awsRegion, awsIdentity, fbRegion, "../backend/cmd/lambda/main.go")
	if err != nil {
		log.Fatal(err)
	}

	fmt.Println("Config assembled succesfully.")

	return config, nil

}

func keyFromKeyName(keyData string) (string, error) {
	parts := strings.Split(keyData, "keys/")
	if len(parts) != 2 {
		return "", fmt.Errorf("invalid key data format")
	}
	return parts[1], nil
}
