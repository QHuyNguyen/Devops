variable "subnet_cidr" {
  type    = list(string)
  default = ["value"]
}

variable "vpc_name" {
  type    = string
  default = "value"
}

variable "vpc_id" {
  type    = string
  default = "value"
}

variable "subnet_count" {
  type    = number
  default = 1
}

variable "availability_zone_suffixes" {
  type        = list(string)
  description = "List of availablity zone suffix"
  default     = ["a", "b", "c"]
}

variable "tiers" {
  type = object({
    subnet_cidrs = list(string)
  })
  default = {
    subnet_cidrs = [""]
  }
}

variable "subnet_name" {
  type    = string
  default = "value"
}
