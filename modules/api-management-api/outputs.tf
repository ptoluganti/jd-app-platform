output "backend" {
  description = "The API backend"
  value = {
    id  = local.backend_id
    url = local.backend_url
  }
}

output "apis" {
  description = "The APIs versioned"
  value       = local.apis
}

output "products" {
  description = "The Products the APIs are assigned to"
  value       = var.apimProductIds
}

locals {
  apis = {
    for k, a in azurerm_api_management_api.api : k => {
      id      = a.id
      version = a.version
    }
  }
}