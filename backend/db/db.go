package db

import (
	"encoding/json"
	"flag"
	"fmt"
	"log"
	"os"

	"cloud.google.com/go/firestore"
	"golang.org/x/net/context"
	"google.golang.org/api/option"
)

var (
	Store *firestore.Client
)


func init(){
	fmt.Println("Initializing Firestore connection...")
	 arg := *flag.String("credentialsAt", "", "Path to the Firebase credentials JSON file")
	fmt.Printf("Using credentials file at: %s\n", arg)
	 flag.Parse()
	if (arg[len(arg)-5:] != ".json") {
		log.Fatal("Please provide a valid JSON file for credentials")
	}
	credentials, err := os.ReadFile(arg); if err != nil {
		log.Fatalf("Error reading credentials file: %v", err)
	}

	if string(credentials) == "" {
		log.Fatal("Credentials not provided")
	}

	opt := option.WithCredentialsJSON([]byte(credentials))

	var data map[string]any
	err = json.Unmarshal(credentials, &data)
	if err != nil {
		log.Fatalf("Error unmarshalling credentials: %v", err)
	}

	client, err := firestore.NewClient(context.Background(), data["project_id"].(string), opt)

	if err != nil || client == nil {
		log.Fatalf("Error initializing Firestore client: %v", err)

	} else {
		fmt.Println("Firestore client initialized successfully")
	}


}