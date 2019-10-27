package main

import (
	"fmt"
	"os"

	"github.com/multi-repo-tools/tools/pkg/utils"
)

func main() {

	args := os.Args
	fmt.Println("linter")
	utils.RunCommand("curl", "-sfL", "https://install.goreleaser.com/github.com/golangci/golangci-lint.sh")
	utils.RunCommand("sh", "-s", "--", "-b", "$(go env GOPATH)/bin latest")
	utils.RunCommand("golangci-lint", "run", "--config", args[1])
}
