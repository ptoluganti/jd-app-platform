variable "apiManagementResourceGroupName" {
  type        = string
  description = "The name of the resource group containing API Management"
}

variable "apiManagementName" {
  type        = string
  description = "The name of the API Management instance"
}

variable "productId" {
  type        = string
  description = "The product Id"
}

variable "productDisplayName" {
  type        = string
  description = "The product display name"
}

variable "productDescription" {
  type        = string
  description = "The product description"
}

variable "subscriptionRequired" {
  type        = bool
  description = "Whether a subscription is required to access the Product, defaults to false."
  default     = false
}

variable "subscriptionNames" {
  type        = list(string)
  description = "A list of names of Product Subscriptions for the Product"
  default     = []
}

variable "policyXmlContent" {
  type        = string
  description = "The Xml content of the policy to be applied to the Product"
  default     = null
}