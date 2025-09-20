package projectcfg

import (
	"errors"
	"strings"
)

type ProjectConfig struct {
	Name           string
	AWSRegion      string
	AWSIdentity    string
	FBRegion       string
	ID             string
	LambdaLocation string
}

func NewProjectConfig(uid, name, awsRegion, awsIdentity, fbRegion, lambdaLocation string) (*ProjectConfig, error) {
	if uid == "" {
		return nil, errors.New("uid cannot be empty")
	}
	if name == "" {
		return nil, errors.New("name cannot be empty")
	}
	if awsRegion == "" {
		return nil, errors.New("awsRegion cannot be empty")
	}
	if awsIdentity == "" {
		return nil, errors.New("awsIdentity cannot be empty")
	}
	if fbRegion == "" {
		return nil, errors.New("fbRegion cannot be empty")
	}

	if lambdaLocation == "" {
		return nil, errors.New("lambdaLocation cannot be empty")
	}

	return &ProjectConfig{
		Name:           name,
		AWSRegion:      strings.TrimSpace(awsRegion),
		AWSIdentity:    strings.TrimSpace(awsIdentity),
		FBRegion:       strings.TrimSpace(fbRegion),
		ID:             name + "-" + uid,
		LambdaLocation: lambdaLocation,
	}, nil
}
