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

# EC2 Instance
resource "aws_instance" "linux_lab" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
  key_name      = var.key_pair_name

  tags = {
    Name = "linux-lab"
  }
}

# EBS Volume 5GB
resource "aws_ebs_volume" "linux_lab_data" {
  availability_zone = aws_instance.linux_lab.availability_zone
  size              = 5
  type              = "gp3"

  tags = {
    Name = "linux-lab-data"
  }
}

# Attach EBS
resource "aws_volume_attachment" "linux_lab" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.linux_lab_data.id
  instance_id = aws_instance.linux_lab.id
}

# Data source para AMI mais recente
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
