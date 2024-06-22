variable "subnet_id" {
    type = string
    description = ""
}

variable "location" {
  type        = string
  default     = "North Europe"
  description = "The location of the resources"
}

variable "resource_group_name" {
  type        = string
  
}

variable "prefix" {
  type        = string
  default     = "apim-mi-demo-01"
  description = "The prefix of the resources"
}