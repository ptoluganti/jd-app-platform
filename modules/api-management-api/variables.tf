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

variable "apmId" {
  description = "The APIM Id such as 'IDA'"
  type        = string
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
  description = "The custom domain private dns zone name"
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
  description = "The suffix for the api path, e.g. '-hub', which is appended onto the name to give e.g. 'business-hub'. Not used if apiPath is specified."
  type        = string
  default     = ""
}

variable "apiPath" {
  description = "The api path, e.g. 'dibi-bff'. Specifying this will override the 'name-apiPathSuffix' default."
  type        = string
  default     = ""
}