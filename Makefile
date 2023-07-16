hello:
	docker-compose run --rm alpine echo 'Hello, World!'
.PHONY: hello

#initialise
init:
	cd environments/non-prod/ap-southeast-2/vpc; terraform init
.PHONY: init

#plan
plan: init
	cd environments/non-prod/ap-southeast-2/vpc; terraform plan -var-file="module.tfvars"
.PHONY: plan