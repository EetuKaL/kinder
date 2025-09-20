package main

import (
	"backend/db"
	"context"
	"fmt"
)


func main() {

	docs := db.Store.Collection("users") .Documents(context.Background())
	
	fmt.Println("Documents:", docs)

	
}
