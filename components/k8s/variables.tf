variable "instance_type" {
  type = string
}

variable "cidr_range" {
  type = string
}

variable "instance_name" {
  type = list(string)
}

#variable "vpc_name" {
#  type = string
#}

variable "owner" {
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

variable "role_name" {
  type = string
}