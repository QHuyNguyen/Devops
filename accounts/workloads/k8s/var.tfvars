instance_type = "t3.micro"
instance_name = ["arthur-test-master-node"]
owner = "arthur"
public_subnet_id = "subnet-0fe03e119e592e7d6"
k8s_sg = "sg-0f65e2adfeaaa01a1"
instance_count = 1
private_ips = ["10.0.0.2"]
role_name = "ssm-arthur"
apply_script = true
script_path = "userdata/k8s/script.sh"
instance_profile_name = "test-profile-2"