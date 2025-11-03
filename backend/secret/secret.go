package secret

type FirebaseConfig struct {
	ProjectID               string `json:"projectId"`
	ClientEmail             string `json:"clientEmail"`
	PrivateKey              string `json:"privateKey"`
	Type                    string `json:"type"`
	PrivateKeyID            string `json:"privateKeyId"`
	ClientID                string `json:"clientId"`
	AuthURI                 string `json:"authUri"`
	TokenURI                string `json:"tokenUri"`
	AuthProviderX509CertURL string `json:"authProviderX509CertUrl"`
	ClientX509CertURL       string `json:"clientX509CertUrl"`
}

var Config FirebaseConfig

/* func init() {
	awsSecret := getSecret("kinder/firebase")
	Config = FirebaseConfig{
		ProjectID:               awsSecret["projectId"],
		ClientEmail:             awsSecret["clientEmail"],
		PrivateKey:              awsSecret["privateKey"],
		Type:                    awsSecret["type"],
		PrivateKeyID:            awsSecret["privateKeyId"],
		ClientID:                awsSecret["clientId"],
		AuthURI:                 awsSecret["authUri"],
		TokenURI:                awsSecret["tokenUri"],
		AuthProviderX509CertURL: awsSecret["authProviderX509CertUrl"],
		ClientX509CertURL:       awsSecret["clientX509CertUrl"],
	}

} */

/*
func getSecret(secretName string) map[string]string {

	region := "<<{{MyRegionName}}>>"

	config, err := config.LoadDefaultConfig(context.TODO(), config.WithRegion(region))
	if err != nil {
		log.Fatal(err)
	}

	// Create Secrets Manager client
	svc := secretsmanager.NewFromConfig(config)

	input := &secretsmanager.GetSecretValueInput{
		SecretId:     aws.String(secretName),
		VersionStage: aws.String("AWSCURRENT"), // VersionStage defaults to AWSCURRENT if unspecified
	}

	result, err := svc.GetSecretValue(context.TODO(), input)
	if err != nil {
		// For a list of exceptions thrown, see
		// https://<<{{DocsDomain}}>>/secretsmanager/latest/apireference/API_GetSecretValue.html
		log.Fatal(err.Error())
	}

	// Decrypts secret using the associated KMS key.
	var secretString string = *result.SecretString


}
*/
