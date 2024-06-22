output "backend" {
  description = "The API backend"
  value       = module.api_management_api.backend
}

output "apis" {
  description = "The APIs versioned"
  value       = module.api_management_api.apis
}

output "products" {
  description = "The APIs (as they are versioned)"
  value       = var.apimProductIds
}

locals {
  apis = {
    for k, a in module.api_management_api.apis : k => {
      id      = a.id
      version = a.version
    }
  }
}