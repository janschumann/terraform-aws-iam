TERRAFORM_PROVIDER = aws

include $(TERRAFORM_MAKE_LIB_HOME)/terraform-module.mk

PKGS := $(shell go list ./... | grep -v /vendor)

.PHONY: go-fmt
go-fmt:
	go fmt ./...

.PHONY: go-lint
go-lint:
	@echo "[golangci-lint] starting"
	@golangci-lint run -c .golangci.yml

.PHONY: go-test
go-test:
	@echo "[go test] starting"
	@go test $(PKGS) -gcflags=-l
