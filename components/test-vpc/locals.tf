locals {
  tiers = {
    "public_subnet" = {
      subnet_cidrs = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
    }
  }
  #    public_subnet = {
  #      subnet_cidrs = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
  #    }
}