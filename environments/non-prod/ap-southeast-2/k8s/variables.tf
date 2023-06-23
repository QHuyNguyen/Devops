variable "instance_type" {
  type = string
}

variable "cidr_range" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "owner" {
  type = string
}

variable "instance_count" {
  type = number
  default = 1
}