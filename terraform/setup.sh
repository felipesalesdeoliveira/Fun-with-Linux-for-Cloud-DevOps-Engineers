#!/bin/bash

# setup.sh - Setup script para Linux Lab Terraform
# Este script ajuda a configurar tudo para começar

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=========================================="
echo "Linux Lab - Terraform Setup Script"
echo "==========================================${NC}"
echo ""

# Check for Terraform
echo -e "${BLUE}[*] Checking Terraform installation...${NC}"
if ! command -v terraform &>/dev/null; then
    echo -e "${RED}[✗] Terraform not found!${NC}"
    echo "Install from: https://www.terraform.io/downloads"
    exit 1
fi
TERRAFORM_VERSION=$(terraform --version | head -n1)
echo -e "${GREEN}[✓] $TERRAFORM_VERSION${NC}"
echo ""

# Check for AWS CLI
echo -e "${BLUE}[*] Checking AWS CLI installation...${NC}"
if ! command -v aws &>/dev/null; then
    echo -e "${RED}[✗] AWS CLI not found!${NC}"
    echo "Install from: https://aws.amazon.com/cli/"
    exit 1
fi
AWS_VERSION=$(aws --version)
echo -e "${GREEN}[✓] $AWS_VERSION${NC}"
echo ""

# Check AWS credentials
echo -e "${BLUE}[*] Checking AWS credentials...${NC}"
if ! aws sts get-caller-identity &>/dev/null; then
    echo -e "${RED}[✗] AWS credentials not configured!${NC}"
    echo "Run: aws configure"
    exit 1
fi
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
REGION=$(aws configure get region)
echo -e "${GREEN}[✓] AWS Account: $ACCOUNT_ID${NC}"
echo -e "${GREEN}[✓] AWS Region: $REGION${NC}"
echo ""

# Check for terraform.tfvars
echo -e "${BLUE}[*] Checking terraform.tfvars...${NC}"
if [ ! -f terraform.tfvars ]; then
    echo -e "${YELLOW}[!] terraform.tfvars not found${NC}"
    if [ -f terraform.tfvars.example ]; then
        echo -e "${YELLOW}[?] Copy terraform.tfvars.example to terraform.tfvars? (y/n)${NC}"
        read -r response
        if [ "$response" = "y" ]; then
            cp terraform.tfvars.example terraform.tfvars
            echo -e "${GREEN}[✓] Created terraform.tfvars${NC}"
            echo ""
            echo -e "${YELLOW}[!] Please edit terraform.tfvars before proceeding${NC}"
            echo "    Especially: key_pair_name and allowed_ssh_cidr"
            exit 0
        fi
    fi
else
    echo -e "${GREEN}[✓] terraform.tfvars exists${NC}"
fi
echo ""

# Initialize Terraform
echo -e "${BLUE}[*] Initializing Terraform...${NC}"
terraform init
echo -e "${GREEN}[✓] Terraform initialized${NC}"
echo ""

# Validate configuration
echo -e "${BLUE}[*] Validating Terraform configuration...${NC}"
terraform validate
echo -e "${GREEN}[✓] Configuration is valid${NC}"
echo ""

# Format files
echo -e "${BLUE}[*] Formatting Terraform files...${NC}"
terraform fmt -recursive
echo -e "${GREEN}[✓] Files formatted${NC}"
echo ""

# Summary
echo -e "${GREEN}=========================================="
echo "Setup Complete!"
echo "==========================================${NC}"
echo ""
echo "Next steps:"
echo ""
echo -e "${BLUE}1. Review your configuration:${NC}"
echo "   cat terraform.tfvars"
echo ""
echo -e "${BLUE}2. Plan the infrastructure:${NC}"
echo "   terraform plan"
echo "   (or: make plan)"
echo ""
echo -e "${BLUE}3. Apply the infrastructure:${NC}"
echo "   terraform apply"
echo "   (or: make apply)"
echo ""
echo -e "${YELLOW}Pro tip: Use 'make help' for more commands${NC}"
echo ""
