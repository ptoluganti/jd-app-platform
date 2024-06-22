variable "resourceGroupName" {
  description = "Resource group where the resource will be deployed"
  type        = string
}

variable "keyVaultName" {
  description = "Name of the Key Vault"
  type        = string
}

variable "skuName" {
  description = "Key vault SKU name"
  type        = string
  default     = "standard"
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created"
  type        = string
  default     = "westeurope"
}

variable "tenantId" {
  description = "Tenant Id for authenticating requests to the Key Vault"
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "privateEndpointName" {
  description = "Key Vault Private Endpoint name"
  type        = string
}

variable "subnetId" {
  description = "Id of subnet for storage account private endpoint"
  type        = string
}

variable "addLocks" {
  type        = bool
  description = "Add locks to resources. Defaults to true."
  default     = true
}

variable "privateDnsResourceGroupName" {
  description = "Private Dns Zone Resource Group Name"
  type        = string
  default     = "rg-we-cs-pdns-prod-01"
}

variable "softDeleteRetentionDays" {
  description = "Soft delete retention days"
  type        = number
  default     = 90
}

variable "rbacAssignments" {
  type = list(object({
    principalId         = string
    roleDefinitionNames = list(string)
  }))
  description = "List containing Entra ID principals and roles to be assigned"
  default     = []
}

variable "enableRbacAuthorization" {
  description = "Flag to indicate if RBAC auth should be enabled"
  type        = bool
  default     = true
}

variable "networkAcls" {
  type = object({
    bypass                  = string
    defaultAction           = string
    ipRules                 = optional(list(string))
    virtualNetworkSubnetIds = optional(list(string))
  })
  description = "The network acls for the key vault"

  default = {
    bypass                  = "AzureServices"
    defaultAction           = "Deny"
    ipRules                 = []
    virtualNetworkSubnetIds = []
  }
}
