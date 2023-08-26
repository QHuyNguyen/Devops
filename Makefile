hello:
	docker-compose run --rm alpine echo 'Hello, World!'

#.phony tell makefile that the command does not involve actual file
.PHONY: hello

sts:
	sudo docker-compose run --rm devops-utils sh -c 'aws sts get-caller-identity'

#initialise
init: sts
#	cd environments/non-prod/ap-southeast-2/vpc; terraform init
	sudo docker-compose run --rm devops-utils sh -c 'cd environments/non-prod/ap-southeast-2/vpc; terraform init'

#plan
plan: sts init
	sudo docker-compose run --rm devops-utils sh -c 'cd environments/non-prod/ap-southeast-2/vpc; terraform plan -var-file="module.tfvars"'

#show
show: sts init plan
	sudo docker-compose run --rm devops-utils sh -c 'cd environments/non-prod/ap-southeast-2/vpc; terraform show'
#apply
apply: sts init
	sudo docker-compose run --rm devops-utils sh -c 'cd environments/non-prod/ap-southeast-2/vpc; terraform apply -var-file="module.tfvars" --auto-approve'
#destroy
destroy: sts init
	sudo docker-compose run --rm devops-utils sh -c 'cd environments/non-prod/ap-southeast-2/vpc; terraform destroy -var-file="module.tfvars" --auto-approve'