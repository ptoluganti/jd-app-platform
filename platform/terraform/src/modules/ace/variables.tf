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

variable "internal_load_balancer_enabled" {
  type        = bool
  description = "Enable Internal Load Balancer"
  default     = false
}


variable "zone_redundancy_enabled" {
  type        = bool
  description = "Enable Zone Redundancy"
  default     = false
}

variable "infrastructure_resource_group_name" {
  type        = string
  description = "The Infrastructure Resource Group Name"
  default     = null

}
variable "log_analytics_workspace_id" {
  type        = string
  description = "The Log Analytics Workspace ID"
  default     = null
}

variable "infrastructure_subnet_id" {
  type        = string
  description = "The Infrastructure Subnet ID"

}

variable "workload_profile" {
  type = map(object({
    name                  = string
    workload_profile_type = string
    maximum_count         = number
    minimum_count         = number
  }))
}

variable "certificates" {
  type = map(object({
    friendly_name  = string
    key_vault_id   = string
    secret_name    = string
    # secret_version = string
  }))
}
