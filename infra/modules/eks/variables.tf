variable "project_name" {
  type    = string
  default = "myapp"
}

variable "environment" {
  type    = string
  default = "dev"
}


variable "az_count" {
  description = "Number of Availability Zones to use"
  type        = number
  default     = 2
}

variable "kubernetes_version" {
  type    = string
  default = "1.30"
}

variable "cluster_role_arn" {
  description = "ARN of the IAM role the EKS control plane assumes"
  type        = string
}

variable "node_role_arn" {
  description = "ARN of the IAM role used by the worker nodes"
  type        = string
}

variable "ebs_csi_role_arn" {
  description = "ARN of the IAM role assumed by the EBS CSI driver (IRSA). Created outside this module."
  type        = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "public_subnet_ids" {
  type = list(string)
}


variable "node_instance_types" {
  type = list(string)
}


variable "node_disk_size" {
  type    = number
  default = 30
}

variable "node_min_size" {
  type    = number
  default = 2
}

variable "node_desired_size" {
  type    = number
  default = 2
}

variable "node_max_size" {
  type    = number
  default = 4
}


variable "api_allowed_cidrs" {
  description = "CIDRs allowed to reach the public Kubernetes API endpoint"
  type        = list(string)
}