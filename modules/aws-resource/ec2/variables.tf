variable "instance_type" {
  type = string
}

variable "instance_name" {
  type = string
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