package main

import (
	"fmt"
	"os"
	"path/filepath"
	"regexp"
	"strings"
)

var linkRe = regexp.MustCompile(`\[.*?\]\((https?://[^)]+)\)`)

func main() {
	err := filepath.Walk("content", func(path string, info os.FileInfo, err error) error {
		if err != nil || info.IsDir() || !strings.HasSuffix(path, ".md") {
			return err
		}

		data, err := os.ReadFile(path)
		if err != nil {
			return err
		}

		matches := linkRe.FindAllStringSubmatch(string(data), -1)
		if len(matches) == 0 {
			return nil
		}

		fmt.Println(path)
		for _, m := range matches {
			fmt.Printf("  %s\n", m[1])
		}
		fmt.Println()

		return nil
	})

	if err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
}