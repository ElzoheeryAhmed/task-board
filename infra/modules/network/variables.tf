variable "vpc_cidr" {
  type    = string
}

variable "project_name" {
  type    = string
}

variable "environment" {
  type    = string
}



variable "az_count" {
  description = "Number of Availability Zones to use"
  type        = number
}


# That’s the pattern the community VPC module uses
variable "nat_strategy" {
  type    = string
  default = "single"
  validation {
    condition     = contains(["single", "per_az"], var.nat_strategy)
    error_message = "nat_strategy must be \"single\" or \"per_az\"."
  }
}




locals {
  azs  = slice(data.aws_availability_zones.available.names, 0, var.az_count)
  name = "${var.project_name}-${var.environment}"
  nat_count = var.nat_strategy == "per_az" ? var.az_count : 1
}