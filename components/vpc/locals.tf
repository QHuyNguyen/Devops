locals {
    tiers = {
        "public_subnet" = {
            subnet_cidrs = var.public_cidr_blocks
        },
        "private_subnet" = {
            subnet_cidrs = var.private_cidr_blocks
        }
    }
}