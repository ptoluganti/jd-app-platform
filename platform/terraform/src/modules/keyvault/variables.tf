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


variable "subnet_id" {
  type        = string
  description = "The Infrastructure Subnet ID"

}

variable "private_dns_zone_id" {
  type        = string
  description = "The Private DNS Zone ID"

}