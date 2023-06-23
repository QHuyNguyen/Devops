variable "instance_type" {
  type = string
}

variable "cidr_range" {
  type = string
}

variable "instance_name" {
  type = list(string)
}

variable "vpc_name" {
  type = string
}

variable "owner" {
  type = string
}