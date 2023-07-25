# Load variable definitions from variables.env
include variables.env

# Variables
DOCKERFILE := Dockerfile

# Docker commands
DOCKER := docker
DOCKER_BUILD := $(DOCKER) build
DOCKER_TAG := $(DOCKER) tag

# Certificate generation commands
ROOT_CA_DIR := rootCA
CERT_DIR := certs
ROOT_KEY := $(ROOT_CA_DIR)/global.key
ROOT_CA  := $(ROOT_CA_DIR)/global.crt
CERT_KEY := $(CERT_DIR)/ca.key
CERT_CSR := $(CERT_DIR)/ca.csr
CERT_PEM := $(CERT_DIR)/ca.crt
CERT_DER := $(CERT_DIR)/ca.der

# Targets
.PHONY: build tag help

build:
	mkdir -p $(CERT_DIR)
	mkdir -p $(ROOT_CA_DIR)
	# Generate root CA keys
	openssl genrsa -out $(ROOT_KEY) 4096
	openssl req -new -x509 -days 365 -subj "/C=US/ST=State/L=City/O=Organization/CN=$(IMAGE_NAME)" -key $(ROOT_KEY) -out $(ROOT_CA)
	# Generate the certificates using OpenSSL
	openssl genrsa -out $(CERT_KEY) 2048
	openssl rsa -in $(CERT_KEY) -outform DER -out $(CERT_DER)
	openssl req -new -key $(CERT_KEY) -out $(CERT_CSR) -subj "/C=US/ST=State/L=City/O=Organization/CN=localhost" 
	# generate PEM for NGINX and DER for LUA
	openssl x509 -req -in $(CERT_CSR) -out $(CERT_PEM) -CA $(ROOT_CA) -CAkey $(ROOT_KEY) -CAcreateserial -days 360 
	# Build the Docker image with the specified version
	$(DOCKER_BUILD) --build-arg VERSION=$(VERSION) -t $(IMAGE_NAME):$(VERSION) -f $(DOCKERFILE) .

tag:
	$(DOCKER_TAG) $(IMAGE_NAME):$(VERSION) $(IMAGE_NAME):latest

help:
	@echo "Available targets:"
	@echo "  build:     Generate certificates and build the Docker image with the specified version."
	@echo "  tag:       Tag the built image with 'latest'."
	@echo "  help:      /* Build project:            make build"
	@echo "             /* Tag as latest (optional): make tag"
	@echo "             /* Docker network is not created by default. You can create by youself. Check compose file"

# Default target
.DEFAULT_GOAL := help
