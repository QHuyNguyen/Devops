variable "instance_type" {
  type = string
}

variable "instance_name" {
  type = list(string)
}

variable "owner" {
  type = string
}

variable "public_subnet_id" {
  type = string
}

variable "k8s_sg" {
  type = string
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "private_ips" {
  type = list(string)
}

variable "role_name" {
  type = string
}

variable "apply_script" {
  type = bool
  default = false
}

variable "script_path" {
  type = string
  default = ""
}

variable "instance_profile_name" {
  type = string
}