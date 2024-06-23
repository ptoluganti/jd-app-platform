variable "name" {
  type        = string
  description = "The name of the Container App"
}

variable "resource_group_name" {
  type        = string
  description = "The Resource Group Name"
}

variable "revision_mode" {
  type        = string
  description = "The revision mode"
  default     = "Single"
}


variable "ingress" {
  type = any
  description = "The Ingress"
  
}

variable "init_container" {
  type = object({
    name = string
    image = string
  })
  description = "Whether to use an init container"
  default     = null
}

variable "containers" {
  type =any
  description = "The Containers"

}

variable "workload_profile_name" {
  type        = string
  description = "The Workload Profile Name"
  default     = "Consumption"
}

variable "container_app_environment_id" {
  type        = string
  description = "The Container App Environment ID"
}

variable "app_identities" {
  type = map(
    object({
      identity_ids = list(string)
      type         = string
    })
  )
  description = "The App Identities"
  default     = {}
}

variable "registry_identities" {
  type = map(
    object({
      server               = string
      identity_id          = string
      username             = string
      password_secret_name = string
    })
  )
  description = "The Registry Identities"
  default     = {}
}

variable "tags" {
  type        = map(any)
  description = "The tags to apply to all resources"
  default = {
  }
}
