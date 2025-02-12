instance_type = "t3.micro"
instance_name = ["arthur-test-ansible"]
owner = "arthur"
public_subnet_id = "subnet-087204a79484c043e"
k8s_sg = "sg-0119c90f34a2363d4"
instance_count = 1
private_ips = ["10.0.0.1"]
role_name = "ssm-arthur"
apply_script = true
script_path = "userdata/ansible/script.sh"
instance_profile_name = "test-profile-1"