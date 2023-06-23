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

variable "instance_count" {
  type = number
  default = 1
}

variable "private_ips" {
  type = list(string)
}