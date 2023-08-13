hello:
	docker-compose run --rm alpine echo 'Hello, World!'

#.phony tell makefile that the command does not involve actual file
.PHONY: hello

sts:
	docker-compose run --rm devops-utils sh -c 'aws sts assume-role --role-arn=arn:aws:iam::722141136946:role/gha-admin-role --role-session-name=prod'
	docker-compose run --rm devops-utils sh -c 'aws sts get-caller-identity'

#initialise
init: sts
#	cd environments/non-prod/ap-southeast-2/vpc; terraform init
	docker-compose run --rm devops-utils sh -c 'cd environments/non-prod/ap-southeast-2/vpc; terraform init'

#plan
plan: sts init
	docker-compose run --rm devops-utils sh -c 'cd environments/non-prod/ap-southeast-2/vpc; terraform plan -var-file="module.tfvars"'

#show
show: sts init plan
	docker-compose run --rm devops-utils sh -c 'cd environments/non-prod/ap-southeast-2/vpc; terraform show'
#apply
apply: sts init
	docker-compose run --rm devops-utils sh -c 'cd environments/non-prod/ap-southeast-2/vpc; terraform apply -var-file="module.tfvars" --auto-approve'
