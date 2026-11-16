.PHONY: help bootstrap generate generate-ts build test clean

# Default target
help:
	@echo "Available targets:"
	@echo "  make bootstrap        - Install required dependencies (protoc, protoc-gen-go)"
	@echo "  make generate         - Generate Go bindings (requires API and VERSION)"
	@echo "  make generate-ts      - Generate TypeScript bindings"
	@echo "  make build            - Build Rust crates"
	@echo "  make test             - Run tests"
	@echo "  make clean            - Clean generated files"
	@echo ""
	@echo "Example usage:"
	@echo "  make bootstrap"
	@echo "  make generate API=multi_agent VERSION=v1"
	@echo "  make generate-ts"
	@echo "  make build"

# Install dependencies
bootstrap:
	./script/bootstrap

# Generate Go bindings
generate:
	@if [ -z "$(API)" ]; then \
		echo "Error: API is required. Usage: make generate API=<api> VERSION=<version>"; \
		echo "Available APIs:"; \
		ls -1 apis; \
		exit 1; \
	fi
	./script/generate -a $(API) -v $(VERSION)

# Generate TypeScript bindings
generate-ts:
	npm ci
	npm run generate:ts

# Build Rust crates
build:
	cargo build

# Build Rust crates in release mode
build-release:
	cargo build --release

# Run tests
test:
	cargo test

# Clean generated files
clean:
	npm run clean
	cargo clean
