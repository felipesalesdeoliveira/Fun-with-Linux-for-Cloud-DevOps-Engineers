.PHONY: help init plan apply destroy fmt validate refresh taint untaint show output

help:
	@echo "=========================================="
	@echo "Linux Lab - Terraform Helper Commands"
	@echo "=========================================="
	@echo ""
	@echo "Available commands:"
	@echo "  make init          Initialize Terraform"
	@echo "  make validate      Validate Terraform configuration"
	@echo "  make fmt           Format Terraform files"
	@echo "  make plan          Preview infrastructure changes"
	@echo "  make apply         Create infrastructure"
	@echo "  make destroy       Destroy infrastructure (CAUTION!)"
	@echo "  make show          Show current state"
	@echo "  make output        Show outputs only"
	@echo "  make refresh       Refresh state from AWS"
	@echo "  make taint-ec2     Taint EC2 instance (will be recreated)"
	@echo "  make untaint-ec2   Untaint EC2 instance"
	@echo "  make taint-ebs     Taint EBS volume (will be recreated)"
	@echo "  make untaint-ebs   Untaint EBS volume"
	@echo "  make clean         Delete local Terraform files"
	@echo ""

init:
	@echo "[*] Initializing Terraform..."
	terraform init

validate:
	@echo "[*] Validating Terraform configuration..."
	terraform validate

fmt:
	@echo "[*] Formatting Terraform files..."
	terraform fmt -recursive

plan:
	@echo "[*] Planning infrastructure changes..."
	terraform plan -out=tfplan

apply: plan
	@echo "[*] Applying infrastructure..."
	terraform apply tfplan

destroy:
	@echo "[!] WARNING: This will destroy all resources!"
	@read -p "Are you sure? [y/N]: " confirm; \
	if [ "$$confirm" = "y" ] || [ "$$confirm" = "Y" ]; then \
		terraform destroy -auto-approve; \
	else \
		echo "Destroy cancelled."; \
	fi

refresh:
	@echo "[*] Refreshing state from AWS..."
	terraform refresh

show:
	@echo "[*] Showing current Terraform state..."
	terraform show

output:
	@echo "[*] Showing Terraform outputs..."
	terraform output

taint-ec2:
	@echo "[*] Tainting EC2 instance..."
	terraform taint aws_instance.linux_lab_ec2

untaint-ec2:
	@echo "[*] Untainting EC2 instance..."
	terraform untaint aws_instance.linux_lab_ec2

taint-ebs:
	@echo "[*] Tainting EBS volume..."
	terraform taint aws_ebs_volume.linux_lab_ebs

untaint-ebs:
	@echo "[*] Untainting EBS volume..."
	terraform untaint aws_ebs_volume.linux_lab_ebs

clean:
	@echo "[*] Cleaning Terraform local files..."
	rm -rf .terraform/
	rm -f .terraform.lock.hcl
	rm -f tfplan
	@echo "[✓] Clean complete"
