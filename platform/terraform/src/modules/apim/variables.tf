variable "location" {
  type        = string
  default     = "North Europe"
  description = "The location of the resources"
}

variable "resource_group_name" {
  type        = string
  description = "The Resource Group Name"
}

variable "prefix" {
  type        = string
  default     = "apim-mi-demo-01"
  description = "The prefix of the resources"
}

variable "contact_name" {
  description = "Full name of the contact person for APIM and SSL certifiate."
  type        = string
}

variable "contact_email" {
  description = "Email address for APIM and SSL renewal notifications."
  type        = string
}

variable "contact_phone" {
  description = "Phone number for APIM and SSL renewal notifications."
  type        = string
}

variable "subnet_id" {
  type        = string
  description = "The subnet ID for the APIM"
}