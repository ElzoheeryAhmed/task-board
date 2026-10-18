variable "name" {
  type    = string
  default = "gp3"
}

variable "reclaim_policy" {
  type    = string
  default = "Retain"
}

variable "volume_type" {
  type    = string
  default = "gp3"
}

variable "encrypted" {
  type    = bool
  default = true
}

variable "fs_type" {
  type    = string
  default = "ext4"
}