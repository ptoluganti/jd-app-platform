variable "apmId" {
  description = "The APIM Id such as 'IDA'"
  type        = string
}

variable "containerAppName" {
  description = "Container App Name"
  type        = string
}

variable "applicationInsightsConnectionString" {
  description = "Application Insights Connection String"
  type        = string
}

variable "containerAppEnvironment" {
  description = "The Container App Environment"
  type = object({
    id                          = string
    staticIpAddress             = string
    customDomainCertificateName = string
    subnetCidr                  = string
    resourceGroupName           = string
  })
}

variable "customDomain" {
  description = "Custom domain for the container app"
  type = object({
    host = string
    privateDnsZone = object({
      name              = string
      resourceGroupName = string
    })
  })
}

variable "containerAppManagedIdentity" {
  description = "The container app managed identity"
  type        = string
}

variable "additionalUserAssignedIdentities" {
  description = "A list of addition user assigned managed identities to assoicate with the container app"
  type        = list(string)
  default     = []
}

/*
When set to true, the default, the Container App will have IP restictions for:
- APIM subnet range (allow APIM to call backend APIs)
- Container App Environment static IP (allow monitoring function hosted in CAs to call backend without APIM)
- Any additional rules supplied in the additional_allowed_ip_rules variable
*/
variable "enableIngressIpRestrictions" {
  description = "Enable ingress ip restriction rules"
  type        = bool
  default     = true
}

# map of rule names and cidrs, such as { "Allow-WE_WIN10_MS":"10.143.64.0/24","Allow-WE_WIN10_MS1":"10.143.65.0/24" }
variable "additionalAllowedIpRules" {
  description = "Additional ingress ip restriction rules"
  type        = map(string)
  default     = {}

  validation {
    condition     = length(setintersection(keys(var.additionalAllowedIpRules), ["Allow-APIManagement", "Allow-ContainerAppEnvironment", "Allow-APIManagement_02"])) == 0
    error_message = "Rules cannot use the reserved names: Allow-APIManagement, Allow-ContainerAppEnvironment, Allow-APIManagement_02."
  }
}

variable "apiManagementSubnetCidr" {
  description = "Api Management Subnet CIDR"
  type        = string
}

variable "apiManagement02SubnetCidr" {
  description = "Api Management 02 Subnet CIDR"
  type        = string
  default     = null
}

variable "containerSecrets" {
  description = "Container App Secrets"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "containerEnvironmentVariables" {
  description = "Container App Environment Variables"
  type = list(object({
    name       = string
    value      = string
    secretName = string
  }))
  default = []
}

variable "acrLoginServer" {
  description = "Azure Container Registry Login Server"
  type        = string
}

variable "containerName" {
  description = "The Container Name"
  type        = string
}

variable "containerImageName" {
  description = "The Container Image Name"
  type        = string
}

variable "region" {
  description = "The Region"
  type        = string
}

variable "sku" {
  description = "The Sku for the containers"
  type = object({
    cpu    = number
    memory = string
  })
}

variable "revisionMode" {
  description = "The revision operational mode"
  type        = string
  default     = "Single"
  validation {
    condition     = contains(["Single", "Multiple "], var.revisionMode)
    error_message = "The revision mode must be either 'Single' or 'Multiple'."
  }
}

variable "maxReplicas" {
  description = "Max Replicas"
  type        = number
}

variable "minReplicas" {
  description = "Min Replicas"
  type        = number
}

variable "environmentAcronym" {
  description = "The Environment Acronym"
  type        = string
}

variable "apiManagement" {
  description = "The configuration for the API Management instance"
  type = object({
    name              = string
    resourceGroupName = string
    loggerId          = string
  })
}

variable "apimProductIds" {
  description = "A list of API Management Products the API will be added to"
  type        = list(string)
  default     = []
}

variable "assetBasePath" {
  description = "The base path to assets such as spec files and policy templates"
  type        = string
  default     = "../../assets/"
}

variable "name" {
  description = "The name of the service, e.g. 'partner'"
  type        = string
}

variable "policyTemplateFile" {
  description = "The name of the policy template"
  type        = string
  default     = "api-policy"
}

variable "apiEnvironment" {
  description = "The environment of the API"
  type        = string
}

variable "validateCertificateName" {
  description = "Validate the backend certificate name"
  type        = bool
  default     = true
}

variable "validateCertificateChain" {
  description = "Validate the backend certificate chain"
  type        = bool
  default     = true
}

variable "versions" {
  description = "A list of API versions with the API spec file content for each"
  type = list(object({
    version     = string
    specContent = string
    specFormat  = string
  }))
}

variable "customDomainPrivateDnsZoneName" {
  description = "The custom domain private dns zone"
  type        = string
}

variable "customDomainHost" {
  description = "The custom domain host, e.g. 'idapartnerapidev'"
  type        = string
}

variable "additionalPolicyParameters" {
  description = "Addition parameters to be used for detokenising the policy template"
  type        = any
  default     = {}
}

variable "apiPathSuffix" {
  description = "The suffix for the api path, e.g. '-hub'."
  type        = string
}