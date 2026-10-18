variable "name" {
  type = string # prefix for resource names, e.g. "dev"
}

variable "security_group_ids" {
  type        = list(string)
  description = "A list of security group IDs to assign to the instance"
}

variable "public_subnet_id" {
  type        = string
  description = "Public Subnet ID to place the bastion host"
}

variable "instance_type" {
  type        = string
  description = "EC2 Instance Type"
}