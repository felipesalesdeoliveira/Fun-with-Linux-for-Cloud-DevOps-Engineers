output "instance_public_ip" {
  value = aws_instance.linux_lab.public_ip
}

output "instance_id" {
  value = aws_instance.linux_lab.id
}

output "ebs_volume_id" {
  value = aws_ebs_volume.linux_lab_data.id
}
