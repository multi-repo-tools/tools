export CGO_ENABLED=0
export GO111MODULE=on

.PHONY: build

build: # @HELP build the Go binaries and run all validations (default)
build: deps
	CGO_ENABLED=1 go build -o build/_output/linter ./cmd/linter

deps: # @HELP ensure that the required dependencies are in place
	go build -v ./...
	bash -c "diff -u <(echo -n) <(git diff go.mod)"
	#bash -c "diff -u <(echo -n) <(git diff go.sum)"

all: build


clean: # @HELP remove all the build artifacts
	rm -rf ./build/_output ./vendor ./cmd/linter/linter

help:
	@grep -E '^.*: *# *@HELP' $(MAKEFILE_LIST) \
    | sort \
    | awk ' \
        BEGIN {FS = ": *# *@HELP"}; \
        {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}; \
    '
