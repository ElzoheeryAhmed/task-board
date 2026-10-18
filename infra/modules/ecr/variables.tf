
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

variable "ecr_repositories" {
  type    = list(string)
  default = ["backend", "frontend"]
}
