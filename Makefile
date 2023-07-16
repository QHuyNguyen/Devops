hello:
	docker-compose run --rm alpine echo 'Hello, World!'

#.phony tell makefile that the command does not involve actual file
.PHONY: hello

#initialise
init:
	cd environments/non-prod/ap-southeast-2/vpc; terraform init

#plan
plan: init
	cd environments/non-prod/ap-southeast-2/vpc; terraform plan -var-file="module.tfvars"

#show
show: init plan
	cd environments/non-prod/ap-southeast-2/vpc; terraform show
#apply
apply: init
	cd environments/non-prod/ap-southeast-2/vpc; terraform apply -var-file="module.tfvars" --auto-approve
