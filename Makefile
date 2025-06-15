init:
	terraform init

plan:
	terraform plan $(ARGS)

apply:
	terraform apply $(ARGS)

destroy:
	terraform destroy $(ARGS)