package utils

import (
	"encoding/json"
	"fmt"
	"os"
	"reflect"
)

func ConvertJsonToString(filePath string) (string, error) {
	file, err := os.Open(filePath)
	if err != nil {
		return "", err
	}
	defer file.Close()

	var result map[string]interface{}
	if err := json.NewDecoder(file).Decode(&result); err != nil {
		return "", err
	}
	bytes, err := json.Marshal(result)
	if err != nil {
		return "", fmt.Errorf("failed to marshal map to JSON: %w", err)
	}
	return string(bytes), nil

}

func MapToStruct(m map[string]interface{}, s interface{}) error {
	v := reflect.ValueOf(s).Elem()
	for key, value := range m {
		field := v.FieldByName(key)
		if field.IsValid() && field.CanSet() {
			val := reflect.ValueOf(value)
			if val.Type().ConvertibleTo(field.Type()) {
				field.Set(val.Convert(field.Type()))
			}
		}
	}
	return nil
}
