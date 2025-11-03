package commands

import (
	"fmt"
	"os/exec"
	"strings"
)

func RunCDKSynth() error {
	output, err := Run("cdk", "synth")
	if err != nil {
		return err
	}
	fmt.Println(output)
	return nil
}

func RunCDKDeploy() error {
	output, err := Run("cdk", "deploy", "--require-approval", "never")
	if err != nil {
		return err
	}
	fmt.Println(output)
	return nil
}

func RunPublishCDKAssets(templatePath, projectId string) error {
	_, err := Run("npx", "cdk-assets", "--path", fmt.Sprintf("%s/%s.assets.json", templatePath, projectId), "publish")
	return err
}

func RunFirestoreExists(project string) (bool, error) {
	output, err := Run("gcloud", "firestore", "databases", "list", "--project="+project)
	if err != nil {
		return false, fmt.Errorf("%s, error: %w", output, err)
	}
	if output == "" {
		return false, nil
	}

	found := findStringFromOutput(output, project)

	if found != "" {
		fmt.Printf("Firestore exists for: %s\n", project)
		return true, nil
	}

	fmt.Printf("Firestore does not exist for: %s\n", project)
	return false, nil

}

func RunCreateFirestore(project, fbRegion string) (bool, error) {
	output, err := Run("gcloud", "firestore", "databases", "create", "--location="+fbRegion, "--database="+project, "--project="+project)

	if err != nil {
		return false, err
	}

	found := findStringFromOutput(output, project)
	if found != "" {
		fmt.Printf("Firestore created for: %s\n", project)
		return true, nil
	}

	fmt.Printf("Firestore not succesfully created for: %s\n", project)
	return false, nil
}

func RunSetFirestoreRules(rules string) error {
	output, err := Run("firebase", "deploy", "--only", "firestore:rules", "--rules", rules)
	if err != nil {
		return err
	}
	fmt.Println(output)
	return nil
}

func RunGetAwsIdentity() (string, error) {
	output, err := Run("aws", "sts", "get-caller-identity", "--query", "Account", "--output", "text")
	if err != nil {
		return "", err
	}
	return output, nil
}

func RunGetAwsRegion() (string, error) {
	output, err := Run("aws", "configure", "get", "region")
	if err != nil {
		return "", err
	}
	return output, nil
}

func RunSetEnvs(envs map[string]string) error {
	for key, value := range envs {
		if err := runSetEnv(key, value); err != nil {
			return err
		}
	}
	return nil
}

func runSetEnv(key string, value string) error {
	_, err := Run("setx", key, value)
	return err
}

func Run(name string, arguments ...string) (string, error) {
	cmd := exec.Command(name, arguments...)
	output, err := cmd.Output()
	if err != nil {
		return "", fmt.Errorf("failed to run command %s %v: %w", name, arguments, err)
	}
	return string(output), nil
}

func findStringFromOutput(output string, find string) string {
	lines := strings.Split(strings.TrimSpace(output), "\n")
	for _, line := range lines {
		if strings.Contains(line, find) {
			return line
		}
	}
	return ""
}
