# ==================== Variables ====================

CSHARP_SOURCE = ./app/backend/csharp-service
GO_SOURCE = ./app/backend/go-service
TF_SOURCE = ./platform/terraform/src
TF_TOOL='tofu'

# ==================== csharp ====================

.PHONY: run-csharp-svc
run-csharp-svc:
	docker compose -f $(CSHARP_SOURCE)/docker-compose.yml up --build 

.PHONY: build-csharp-svc
build-csharp-svc:
	docker build -t ptoluganti/csharp-service -f $(CSHARP_SOURCE)/Dockerfile $(CSHARP_SOURCE)

.PHONY: push-csharp-svc
push-csharp-svc: build-csharp-svc
	docker push ptoluganti/csharp-service:latest

# ==================== Go ====================

.PHONY: run-go-svc
run-go-svc:
	docker compose -f $(GO_SOURCE)/docker-compose.yml up --build 
.PHONY: build-go-svc
build-go-svc:
	docker build -t ptoluganti/go-service -f $(GO_SOURCE)/Dockerfile $(GO_SOURCE)

.PHONY: push-go-svc
push-go-svc: build-go-svc
	docker push ptoluganti/go-service:latest

# ==================== Terraform ====================

# Validate the Terraform configuration
.PHONY: validate
validate:
	$(TF_TOOL) -chdir=$(TF_SOURCE) validate 

# Initialize the Terraform configuration
.PHONY: init
init:
	$(TF_TOOL) -chdir=$(TF_SOURCE) init -input=false -upgrade -reconfigure

# Generate and show an execution plan
.PHONY: plan
plan:
	$(TF_TOOL) -chdir=$(TF_SOURCE) plan -out=plan.tfplan

# Apply the changes required to reach the desired state
.PHONY: apply
apply:
	$(TF_TOOL) -chdir=$(TF_SOURCE) apply plan.tfplan

# Destroy the Terraform-managed infrastructure
.PHONY: destroy
destroy:
	$(TF_TOOL) -chdir=$(TF_SOURCE) destroy --auto-approve

# Clean up generated files
.PHONY: clean
clean:
	rm -f plan.tfplan

# Run all steps
.PHONY: run
run: init validate plan apply