variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}


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
  my_ip_cidr = "${chomp(data.http.myip.response_body)}/32"
}









variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}


