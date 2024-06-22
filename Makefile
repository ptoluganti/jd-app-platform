
# ==================== csharp ====================

.PHONY: run-csharp-svc
run-csharp-svc:
	docker compose -f ./app/backend/csharp-service/docker-compose.yml up --build 

.PHONY: build-csharp-svc
build-csharp-svc:
	docker build -t ptoluganti/csharp-service -f ./app/backend/csharp-service/Dockerfile ./app/backend/csharp-service

.PHONY: push-csharp-svc
push-csharp-svc: build-csharp-svc
	docker push ptoluganti/csharp-service:latest

# ==================== Go ====================

.PHONY: run-go-svc
run-go-svc:
	docker compose -f ./app/backend/go-service/docker-compose.yml up --build 
.PHONY: build-go-svc
build-go-svc:
	docker build -t ptoluganti/go-service -f ./app/backend/go-service/Dockerfile ./app/backend/go-service

.PHONY: push-go-svc
push-go-svc: build-go-svc
	docker push ptoluganti/go-service:latest

# ==================== Terraform ====================

.PHONY: tfvalidate
tfvalidate:
	tofu -chdir=./platform/terraform/src validate 

.PHONY: tfinit
tfinit: tfvalidate
	tofu -chdir=./platform/terraform/src init -input=false -upgrade -reconfigure

.PHONY: tfplan
tfplan: tfinit
	tofu -chdir=./platform/terraform/src plan -out=./tfplan -input=false -detailed-exitcode

.PHONY: tfapply
tfapply: 
	tofu -chdir=./platform/terraform/src apply "./tfplan"

.PHONY: tfdestroy
tfdestroy: 
	tofu -chdir=./platform/terraform/src destroy --auto-approve
