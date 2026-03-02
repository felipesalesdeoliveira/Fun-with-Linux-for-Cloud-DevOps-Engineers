output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.linux_lab_vpc.id
}

output "subnet_id" {
  description = "Subnet ID"
  value       = aws_subnet.linux_lab_subnet.id
}

output "security_group_id" {
  description = "Security Group ID"
  value       = aws_security_group.linux_lab_sg.id
}

output "ec2_instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.linux_lab_ec2.id
}

output "ec2_public_ip" {
  description = "EC2 Public IP Address"
  value       = aws_instance.linux_lab_ec2.public_ip
}

output "ec2_private_ip" {
  description = "EC2 Private IP Address"
  value       = aws_instance.linux_lab_ec2.private_ip
}

output "ec2_availability_zone" {
  description = "EC2 Availability Zone"
  value       = aws_instance.linux_lab_ec2.availability_zone
}

output "ebs_volume_id" {
  description = "EBS Volume ID"
  value       = aws_ebs_volume.linux_lab_ebs.id
}

output "ebs_volume_size" {
  description = "EBS Volume Size (GB)"
  value       = aws_ebs_volume.linux_lab_ebs.size
}

output "ebs_device_name" {
  description = "Device name for EBS volume attachment"
  value       = var.ebs_device_name
}

output "ssh_connection_command" {
  description = "SSH command to connect to the instance"
  value       = "ssh -i /path/to/key.pem ec2-user@${aws_instance.linux_lab_ec2.public_ip}"
}

output "instance_details" {
  description = "Complete instance details"
  value = {
    instance_id = aws_instance.linux_lab_ec2.id
    public_ip   = aws_instance.linux_lab_ec2.public_ip
    private_ip  = aws_instance.linux_lab_ec2.private_ip
    instance_type = aws_instance.linux_lab_ec2.instance_type
    ami_id        = aws_instance.linux_lab_ec2.ami
  }
}
