package lambda_builder

import (
	"encoding/base64"
	"encoding/json"
	"fmt"
	"io/fs"
	"os"
	"os/exec"
	"path/filepath"
	"stack/pkg/zip"
	"strings"
)

//  Build and zips the lambda function code for IAC deployment.
// Requires the location of the lambda function and the Firebase config file.
// Returns the location of the zipped lambda function.

func BuildAndZip(lambdaLocation string, authCredentials []byte) (string, error) {
	fmt.Println("Starting to build and zip the lambda function...")

	if lambdaLocation == "" || len(authCredentials) == 0 {
		return "", fmt.Errorf("lambdaLocation cannot be empty and authCredentials cannot be empty")
	}
	currentDir, err := os.Getwd()
	if err != nil {
		return "", fmt.Errorf("failed to get current working directory, error: %v", err)
	}

	outputDir := filepath.Join(currentDir, "generated")
	if _, err := os.Stat(outputDir); os.IsNotExist(err) {
		if err := os.MkdirAll(outputDir, os.ModePerm); err != nil {
			return "", fmt.Errorf("failed to create generated directory, error: %v", err)
		}
	}

	err = clearGeneratedLambdaBuildFiles(outputDir)
	if err != nil {
		return "", err
	}

	absPath, err := filepath.Abs(lambdaLocation)
	if err != nil {
		return "", fmt.Errorf("failed to resolve lambda location: %v", err)
	}
	lambdaLocation = absPath

	lambdaRoot, packageName := filepath.Split(absPath)

	fmt.Printf("Lambda location: %s\n", lambdaLocation)
	fmt.Printf("Lambda root: %s\n", lambdaRoot)
	fmt.Printf("Package name: %s\n", packageName)

	mainExists, err := checkMainExists(lambdaRoot)
	if err != nil {
		return "", fmt.Errorf("failed to check if main.go exists, error: %v", err)
	}
	if !mainExists {
		return "", fmt.Errorf("main.go not found in lambda location: %s", lambdaLocation)
	}

	fmt.Println("Building zip file for lambda function...")

	privateKey, err := privateKeyFromCredentials(authCredentials)
	if err != nil {
		return "", fmt.Errorf("failed to extract private key from auth credentials, error: %v", err)
	}
	fmt.Printf("Successfully extracted private key.\n")

	privateKeyId, err := getPrivateKeyIdFromCredentials(authCredentials)
	if err != nil {
		return "", fmt.Errorf("failed to extract private_key_id from auth credentials, error: %v", err)
	}
	fmt.Printf("Successfully extracted private_key_id\n")

	encodedKey := base64.StdEncoding.EncodeToString([]byte(privateKey))

	ldflags := fmt.Sprintf("-X %s.Key=%s -X %s.KeyId=%s",
		"main", encodedKey, "main", privateKeyId)

	fmt.Printf("LAMBDA LOCATION %s", lambdaLocation)
	fmt.Printf("CURRENT DIR %s", currentDir)
	// Build a Linux executable named 'bootstrap' for custom runtime
	cmd := exec.Command("go", "build", "-ldflags", ldflags, "-o", fmt.Sprintf("%s/bootstrap", outputDir), lambdaLocation)
	cmd.Dir = lambdaRoot
	cmd.Env = append(os.Environ(),
		"GOOS=linux",
		"GOARCH=amd64",
		"CGO_ENABLED=0",
	)

	_, err = cmd.CombinedOutput()
	if err != nil {
		return "", fmt.Errorf("building lambda failed, Error: %v", err)
	}
	fmt.Printf("Successfully built lambda binary.\n")

	source := filepath.Join(outputDir, "bootstrap")
	output := filepath.Join(outputDir, "bootstrap.zip")

	err = zip.Compress(source, output)
	if err != nil {
		return "", fmt.Errorf("failed to compress lambda binary, error: %v", err)
	}

	return output, nil
}

func getKeyValueFromByte(authCredentials []byte, key string) (string, error) {

	authMap := map[string]string{}
	if err := json.Unmarshal(authCredentials, &authMap); err != nil {
		return "", fmt.Errorf("failed to parse auth credentials: %v", err)
	}
	value := authMap[key]
	if value == "" {
		return "", fmt.Errorf("private_key missing in auth credentials")
	}
	return value, nil
}
func getPrivateKeyIdFromCredentials(authCredentials []byte) (string, error) {
	privateKeyId, err := getKeyValueFromByte(authCredentials, "private_key_id")
	if err != nil {
		return "", err
	}
	return privateKeyId, nil
}

func privateKeyFromCredentials(authCredentials []byte) (string, error) {
	privateKey, err := getKeyValueFromByte(authCredentials, "private_key")
	//fmt.Printf("Raw private key: %s\n", privateKey)
	if err != nil {
		return "", err
	}

	privateString := strings.ReplaceAll(privateKey, "\\n", "\n")
	start := "-----BEGIN PRIVATE KEY-----"
	end := "-----END PRIVATE KEY-----"

	privateString = strings.TrimPrefix(privateString, start+"\n")
	privateString = strings.TrimSuffix(privateString, "\n"+end)

	return privateString, nil
}

func clearGeneratedLambdaBuildFiles(dir string) error {
	err := search(dir,
		func(e fs.DirEntry) bool {
			return e.Name() == "bootstrap" || e.Name() == "bootstrap.exe" || e.Name() == "bootstrap.zip"
		},
		func(e fs.DirEntry) {
			fmt.Printf("Removing old lambda build file: %s\n", e.Name())
			os.Remove(filepath.Join(dir, e.Name()))
		},
	)
	if err != nil {
		return err
	}
	return nil
}

func checkMainExists(filePath string) (bool, error) {
	var found = false
	err := search(filePath, func(e fs.DirEntry) bool {
		return e.Name() == "main.go"
	}, func(e fs.DirEntry) {
		found = true
	})
	return found, err
}
func search(dir string, fn func(fs.DirEntry) bool, action func(fs.DirEntry)) error {
	entries, err := os.ReadDir(dir)
	if err != nil {
		return fmt.Errorf("failed to read directory: %v", err)
	}
	for _, entry := range entries {
		if fn(entry) {
			action(entry)
		}
	}
	return nil
}
