# ==================== Variables ====================

csharp_source = ./app/backend/csharp-service
go_source = ./app/backend/go-service
tf_source = ./platform/terraform/src

# ==================== csharp ====================

.PHONY: run-csharp-svc
run-csharp-svc:
	docker compose -f $(csharp_source)/docker-compose.yml up --build 

.PHONY: build-csharp-svc
build-csharp-svc:
	docker build -t ptoluganti/csharp-service -f $(csharp_source)/Dockerfile $(csharp_source)

.PHONY: push-csharp-svc
push-csharp-svc: build-csharp-svc
	docker push ptoluganti/csharp-service:latest

# ==================== Go ====================

.PHONY: run-go-svc
run-go-svc:
	docker compose -f $(go_source)/docker-compose.yml up --build 
.PHONY: build-go-svc
build-go-svc:
	docker build -t ptoluganti/go-service -f $(go_source)/Dockerfile $(go_source)

.PHONY: push-go-svc
push-go-svc: build-go-svc
	docker push ptoluganti/go-service:latest

# ==================== Terraform ====================

.PHONY: tfvalidate
tfvalidate:
	tofu -chdir=$(tf_source) validate 

.PHONY: tfinit
tfinit: tfvalidate
	tofu -chdir=$(tf_source) init -input=false -upgrade -reconfigure

.PHONY: tfplan
tfplan: tfinit
	tofu -chdir=$(tf_source) plan -out=./tfplan

.PHONY: tfapply
tfapply: tfplan
	tofu -chdir=$(tf_source) apply "./tfplan"

.PHONY: tfclean
tfclean: 
	tofu -chdir=$(tf_source) destroy --auto-approve
