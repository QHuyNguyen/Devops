instance_type = "t3.micro"
cidr_range = "10.0.0.0/16"
private_ips = ["10.0.1.50", "10.0.1.60",]
instance_name = ["arthur-worker-node", "arthur-master-node"]
vpc_name = "k8s-vpc"
owner = "arthur"
instance_count = 2
