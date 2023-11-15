vpc_cidr     = "10.0.0.0/16"
subnet_count = 2
subnet_cidr  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
vpc_name     = "devops-vpc-test"
owner        = "arthur"
#subnet_name  = ["devops-vpc-public-subnet-A-test", "devops-vpc-private-subnet-A-test"]

public_cidr_blocks = [
  "10.0.1.0/24",
  "10.0.2.0/24",
  "10.0.3.0/24"
]

private_cidr_blocks = [
  "10.0.4.0/24",
  "10.0.5.0/24",
  "10.0.6.0/24"
]

