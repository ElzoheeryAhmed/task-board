output "bastion_public_ip" {
  value       = aws_eip.bastion_eip.public_ip
  description = "Public Elastic IP assigned to the Bastion host"
}

output "bastion_instance_id" {
  value       = aws_instance.bastion.id
  description = "EC2 Instance ID of the Bastion host"
}