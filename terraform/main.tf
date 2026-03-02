terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# ===================================
# VPC e Networking
# ===================================

resource "aws_vpc" "linux_lab_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.project_name}-vpc"
    Environment = var.environment
  }
}

resource "aws_subnet" "linux_lab_subnet" {
  vpc_id                  = aws_vpc.linux_lab_vpc.id
  cidr_block              = var.subnet_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.project_name}-subnet"
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "linux_lab_igw" {
  vpc_id = aws_vpc.linux_lab_vpc.id

  tags = {
    Name        = "${var.project_name}-igw"
    Environment = var.environment
  }
}

resource "aws_route_table" "linux_lab_rt" {
  vpc_id = aws_vpc.linux_lab_vpc.id

  route {
    cidr_block      = "0.0.0.0/0"
    gateway_id      = aws_internet_gateway.linux_lab_igw.id
  }

  tags = {
    Name        = "${var.project_name}-rt"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "linux_lab_rta" {
  subnet_id      = aws_subnet.linux_lab_subnet.id
  route_table_id = aws_route_table.linux_lab_rt.id
}

# ===================================
# Security Group
# ===================================

resource "aws_security_group" "linux_lab_sg" {
  name        = "${var.project_name}-sg"
  description = "Security group for Linux Lab EC2 instance"
  vpc_id      = aws_vpc.linux_lab_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidr
    description = "SSH access"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name        = "${var.project_name}-sg"
    Environment = var.environment
  }
}

# ===================================
# EC2 Instance
# ===================================

resource "aws_instance" "linux_lab_ec2" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.linux_lab_subnet.id
  vpc_security_group_ids = [aws_security_group.linux_lab_sg.id]
  key_name               = var.key_pair_name == "" ? null : var.key_pair_name

  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.root_volume_size
    delete_on_termination = true

    tags = {
      Name = "${var.project_name}-root-volume"
    }
  }

  monitoring              = true
  disable_api_termination = false

  tags = {
    Name        = "${var.project_name}-ec2"
    Environment = var.environment
  }

  user_data = base64encode(templatefile("${path.module}/user_data.sh", {
    project_name = var.project_name
  }))

  depends_on = [
    aws_internet_gateway.linux_lab_igw
  ]
}

# ===================================
# EBS Volume (5GB) - Secundário
# ===================================

resource "aws_ebs_volume" "linux_lab_ebs" {
  availability_zone = aws_instance.linux_lab_ec2.availability_zone
  size              = var.ebs_volume_size
  type              = var.ebs_volume_type
  encrypted         = true

  tags = {
    Name        = "${var.project_name}-ebs-volume"
    Environment = var.environment
  }
}

resource "aws_volume_attachment" "linux_lab_ebs_attachment" {
  device_name = var.ebs_device_name
  volume_id   = aws_ebs_volume.linux_lab_ebs.id
  instance_id = aws_instance.linux_lab_ec2.id
}

# ===================================
# Data Sources
# ===================================

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
