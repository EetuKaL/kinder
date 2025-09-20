package zip

import (
    "archive/zip"
    "fmt"
    "io"
    "os"
    "path/filepath"
)

func Compress(sourceFilePath string, zipFilePath string) error {

	file, err := os.Create(zipFilePath)
	if err != nil {
		return fmt.Errorf("failed to create zip file, error: %v", err)
	}
	writer := zip.NewWriter(file)
	defer writer.Close()

	src, err := os.Open(sourceFilePath)
	if err != nil {
		return fmt.Errorf("failed to open source file, error: %v", err)
	}
	defer src.Close()

    f, err := writer.Create(filepath.Base(sourceFilePath))
    if err != nil {
        return fmt.Errorf("failed to create zip entry, error: %v", err)
    }
	io.Copy(f, src)
	return nil
}
