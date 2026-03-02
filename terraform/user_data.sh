#!/bin/bash
set -e

echo "=========================================="
echo "Linux Lab - EC2 Initialization Script"
echo "=========================================="
echo "Project: ${project_name}"
echo "Timestamp: $(date)"
echo ""

# Update system
echo "[*] Updating system packages..."
yum update -y
yum upgrade -y

# Install essential tools
echo "[*] Installing essential tools..."
yum install -y \
    git \
    vim \
    nano \
    wget \
    curl \
    net-tools \
    htop \
    tree \
    aws-cli

# Configure hostname
echo "[*] Configuring hostname..."
hostnamectl set-hostname ${project_name}-server

# Create log directory
echo "[*] Setting up logging..."
mkdir -p /var/log/linux-lab
LOG_FILE="/var/log/linux-lab/init.log"

# Log system information
cat > $LOG_FILE << 'EOFLOG'
========================================
Linux Lab - System Information
========================================
EOFLOG

echo "Timestamp: $(date)" >> $LOG_FILE
echo "Hostname: $(hostnamectl --static)" >> $LOG_FILE
echo "Kernel: $(uname -r)" >> $LOG_FILE
echo "OS: $(cat /etc/os-release | grep PRETTY_NAME)" >> $LOG_FILE
echo "" >> $LOG_FILE

# List available disks
echo "[*] Available Disks:" | tee -a $LOG_FILE
lsblk >> $LOG_FILE 2>&1

# Create projects directory
echo "[*] Creating project directories..."
mkdir -p /home/projects/linux-lab
mkdir -p /home/projects/linux-lab/backups

# Set better shell prompt
echo "[*] Configuring shell..."
cat >> /etc/bashrc << 'EOFBASH'

# Custom PS1 for better visibility
export PS1='\u@\h[\w]\$ '
EOFBASH

# Security hardening - set correct permissions
echo "[*] Applying security settings..."
chmod 644 /etc/passwd
chmod 000 /etc/shadow
chmod 644 /etc/group
chmod 000 /etc/gshadow

# Enable SELinux (optional, can be changed)
# setenforce 1

echo "=========================================="
echo "Initialization Complete!"
echo "=========================================="
echo "Check logs at: $LOG_FILE"
echo ""
echo "Next steps:"
echo "1. SSH into the instance"
echo "2. Format and mount the EBS volume:"
echo "   sudo mkfs.ext4 /dev/nvme1n1"
echo "   sudo mkdir -p /mnt/data"
echo "   sudo mount /dev/nvme1n1 /mnt/data"
echo "3. Start the Linux Lab exercises!"
echo ""
