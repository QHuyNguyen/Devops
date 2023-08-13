hello:
	docker-compose run --rm alpine echo 'Hello, World!'

#.phony tell makefile that the command does not involve actual file
.PHONY: hello

sts:
	docker-compose run --rm devops-utils sh -c 'aws sts get-caller-identity'

#initialise
init:
#	cd environments/non-prod/ap-southeast-2/vpc; terraform init
	docker-compose run --rm devops-utils sh -c 'cd environments/non-prod/ap-southeast-2/vpc; terraform init'

#plan
plan: init
	docker-compose run --rm devops-utils sh -c 'cd environments/non-prod/ap-southeast-2/vpc; terraform plan -var-file="module.tfvars"''

#show
show: init plan
	docker-compose run --rm devops-utils sh -c 'cd environments/non-prod/ap-southeast-2/vpc; terraform show'
#apply
apply: init
	docker-compose run --rm devops-utils sh -c 'cd environments/non-prod/ap-southeast-2/vpc; terraform apply -var-file="module.tfvars" --auto-approve'
