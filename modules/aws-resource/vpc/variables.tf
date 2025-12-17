variable "vpc_cidr" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "owner" {
  type = string
}

variable "tiers" {
  description = "Object type map means the values are of type object"
#  tiers = {
#    public_subnet = {
#      cidr_block = 10.0.0.0/16
#    }
#  }
#Key will be public_subnet and Value will be cidr_block = 10.0.0.0/16 (type object)
  type = map(object(
    {
      subnet_cidrs = list(string)
    }
  ))
  #default = {
  #    subnet_cidrs = [""]
  #}
}
