variable "instance_type" {
  type = string
}

variable "instance_name" {
  type = list(string)
  default = ["test"]
}

variable "owner" {
  type = string
}

variable "public_subnet_id" {
  type = string
}

variable "private_subnet_id" {
  type = string
}

variable "k8s_sg" {
  type = string
}

variable "public_instance_count" {
  type    = number
  default = 0
}
variable "private_instance_count" {
  type    = number
  default = 0
}

variable "private_ips" {
  type = list(string)
}

variable "ssm_role_name" {
  type = string
}
