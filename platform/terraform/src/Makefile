

.PHONY: tfvalidate
tfvalidate:
	tofu validate


.PHONY: tfinit
tfinit: tfvalidate
	tofu init -input=false -upgrade -reconfigure

.PHONY: tfplan
tfplan: tfinit
	tofu plan -out=tfplan -input=false -detailed-exitcode

.PHONY: tfapply
tfapply: 
	tofu apply "./tfplan"

.PHONY: tfdestroy
tfdestroy: 
	tofu destroy --auto-approve
