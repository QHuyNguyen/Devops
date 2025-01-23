#/bin/bash
WORKING_DIR = components/${COMPONENT}
VAR_FILE = "../../accounts/${TYPE}/${AWS_ACCOUNT_NAME}/var.tfvars"
#BACKEND_KEY = $(COMPONENT)/instance-terraform.tfstate

BACKEND_CONFIG = \
	-backend-config="bucket=arthur-cmd-state-file-bucket" \
	-backend-config="key=${COMPONENT}/instance-terraform.tfstate" \
	-backend-config="region=ap-southeast-2"

hello:
	docker-compose run --rm alpine echo 'Hello, World!'

#.phony tell makefile that the command does not involve actual file
.PHONY: hello

sts:
	sudo docker compose run --rm devops-utils sh -c 'aws sts get-caller-identity'

#initialise
init: sts
#	cd environments/non-prod/ap-southeast-2/vpc; terraform init
#	sudo docker-compose run --rm devops-utils sh -c 'cd environments/non-prod/ap-southeast-2/vpc; terraform init'
	sudo docker-compose run --rm devops-utils sh -c 'cd ${WORKING_DIR}; terraform init ${BACKEND_CONFIG}'

init-test:
	sudo docker compose run --rm devops-utils sh -c 'cd ${WORKING_DIR}; terraform init'
plan-test:
	sudo docker compose run --rm devops-utils sh -c 'cd ${WORKING_DIR}; terraform plan -var-file=${VAR_FILE}'
apply-test: init-test
	sudo docker compose run --rm devops-utils sh -c 'cd ${WORKING_DIR}; terraform apply -var-file=${VAR_FILE}'

#plan
plan: sts init
#	sudo docker-compose run --rm devops-utils sh -c 'cd environments/non-prod/ap-southeast-2/vpc; terraform plan -var-file="module.tfvars"'
	sudo docker-compose run --rm devops-utils sh -c 'cd ${WORKING_DIR}; terraform plan -var-file="../../accounts/environments/non-prod/$(COMPONENT)/module.tfvars"'

#show
show: sts init plan
#	sudo docker-compose run --rm devops-utils sh -c 'cd environments/non-prod/ap-southeast-2/vpc; terraform show'
	sudo docker-compose run --rm devops-utils sh -c 'cd ${WORKING_DIR}; terraform show'
#apply
apply: sts init
#	sudo docker-compose run --rm devops-utils sh -c 'cd environments/non-prod/ap-southeast-2/vpc; terraform apply -var-file="module.tfvars" --auto-approve'
	sudo docker-compose run --rm devops-utils sh -c 'cd ${WORKING_DIR}; terraform apply -var-file="../../accounts/environments/non-prod/$(COMPONENT)/module.tfvars" --auto-approve'
#destroy
destroy: sts init
#	sudo docker-compose run --rm devops-utils sh -c 'cd environments/non-prod/ap-southeast-2/vpc; terraform destroy -var-file="module.tfvars" --auto-approve'
	sudo docker-compose run --rm devops-utils sh -c 'cd ${WORKING_DIR}; terraform destroy -var-file="../../accounts/environments/non-prod/$(COMPONENT)/module.tfvars" --auto-approve'