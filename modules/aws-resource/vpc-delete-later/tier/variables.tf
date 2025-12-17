variable "subnet_cidr" {
  type = list(string)
}

variable "vpc_name" {
  type = string
}

variable "vpc_id" {
  type = string
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
}

variable "subnet_name" {
  type = string
}
