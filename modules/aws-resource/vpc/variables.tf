variable "vpc_cidr" {
  type = string
}

variable "subnet_cidr" {
  type = list(string)
}

variable "vpc_name" {
  type = string
}

variable "owner" {
  type = string
}

variable "subnet_count" {
  type = number
  default = 1
}

variable "subnet_name" {
  type = list(string)
}