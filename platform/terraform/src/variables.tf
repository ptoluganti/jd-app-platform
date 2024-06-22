variable "location" {
  type        = string
  default     = "North Europe"
  description = "The location of the resources"
}

variable "prefix" {
  type        = string
  default     = "apim-demo-01"
  description = "The prefix of the resources"
}

variable "root_dns_name" {
  type        = string
  default     = "apim-demo-01.com"
  description = "The root domain name to be used for exposing the APIM site."
}

variable "contact_name" {
  description = "Full name of the contact person for APIM and SSL certifiate."
  type        = string
  default     = "Pradeep Toluganti"
}

variable "contact_email" {
  description = "Email address for APIM and SSL renewal notifications."
  type        = string
  default     = "pradeep.toluganti@hotmail.com"
}

variable "contact_phone" {
  description = "Phone number for APIM and SSL renewal notifications."
  type        = string
  default     = "07944266584"
}
