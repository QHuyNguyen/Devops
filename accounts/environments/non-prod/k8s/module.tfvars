instance_type = "t2.2xlarge"
cidr_range    = "10.0.0.0/16"
#private_ips   = ["10.0.1.50", "10.0.1.200"]
instance_name = ["arthur-worker-node", "arthur-master-node"]
#vpc_name       = "k8s-vpc"
role_name = "ssm-role-arthur"
owner          = "arthur"
public_instance_count = 1
private_instance_count = 1
