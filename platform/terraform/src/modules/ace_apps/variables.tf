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


variable "log_analytics_workspace_id" {
  type        = string
  description = "The Log Analytics Workspace ID"
  
}

variable "infrastructure_subnet_id" {
  type        = string
  description = "The Infrastructure Subnet ID"
  
}

variable "workload_profiles" {
  type = map(object({
    name                  = string
    workload_profile_type = string
    maximum_count         = number
    minimum_count         = number
  }))
}