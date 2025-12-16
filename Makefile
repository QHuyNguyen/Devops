#/bin/bash
WORKING_DIR = components/${COMPONENT}
VAR_FILE = "../../accounts/${ACCOUNT_GROUP}/${ACCOUNT_DOMAIN}/var.tfvars"
BACKEND_KEY = "${ACCOUNT_GROUP}/${COMPONENT}/instance-terraform.tfstate"
BACKEND_BUCKET = devops-blog-arthur-200

BACKEND_CONFIG = \
	-backend-config="bucket=${BACKEND_BUCKET}" \
	-backend-config="key=${BACKEND_KEY}" \
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
	sudo docker compose run --rm devops-utils sh -c 'cd ${WORKING_DIR}; terraform init ${BACKEND_CONFIG}'

plan: sts init
	sudo docker compose run --rm devops-utils sh -c 'cd ${WORKING_DIR}; terraform plan -no-color -var-file=${VAR_FILE}'
apply: sts init
	sudo docker compose run --rm devops-utils sh -c 'cd ${WORKING_DIR}; terraform apply -var-file=${VAR_FILE} --auto-approve'
destroy: sts init
	sudo docker compose run --rm devops-utils sh -c 'cd ${WORKING_DIR}; terraform destroy -var-file=${VAR_FILE} --auto-approve'
show: sts init plan
#	sudo docker-compose run --rm devops-utils sh -c 'cd environments/non-prod/ap-southeast-2/vpc; terraform show'
	sudo docker-compose run --rm devops-utils sh -c 'cd ${WORKING_DIR}; terraform show'