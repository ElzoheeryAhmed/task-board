
variable "project_name" {
  type    = string
  default = "myapp"
}

variable "environment" {
  type    = string
  default = "dev"
}



variable "oidc_issuer_url" {
  type = string
}