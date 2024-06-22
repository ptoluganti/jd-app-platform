resource "azurerm_container_app_environment" "ace" {
  name                           = "${var.prefix}-Environment-01"
  location                       = var.location
  resource_group_name            = var.resource_group_name
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  infrastructure_subnet_id       = var.infrastructure_subnet_id
  internal_load_balancer_enabled = true

  dynamic "workload_profile" {
    for_each = var.workload_profiles
    content {
      name                  = workload_profile.value.name
      workload_profile_type = workload_profile.value.workload_profile_type
      maximum_count         = workload_profile.value.maximum_count
      minimum_count         = workload_profile.value.minimum_count
    }
  }
  # workload_profile {
  #   name                  = "app-backend"
  #   workload_profile_type = "D4"
  #   maximum_count         = 2
  #   minimum_count         = 1
  # }
}

# resource "azurerm_container_app" "aca_album_backend" {
#   name                         = "aca-album-backend"
#   container_app_environment_id = azurerm_container_app_environment.container_app_backend.id
#   resource_group_name          = azurerm_resource_group.private.name
#   revision_mode                = "Single"
#   workload_profile_name        = "app-backend"

#   identity {
#     type = "SystemAssigned"
#   }

#   template {
#     container {
#       name   = "aca-album-backend"
#       image  = "ghcr.io/houssemdellai/containerapps-album-backend:v1"
#       cpu    = 0.25
#       memory = "0.5Gi"
#     }
#   }

#   ingress {
#     target_port      = 3500
#     external_enabled = true
#     traffic_weight {
#       percentage      = 100
#       latest_revision = true
#     }
#   }
# }

# resource "azurerm_container_app_environment" "container_app_frontned" {
#   name                           = "${var.prefix}-Environment-02"
#   location                       = azurerm_resource_group.public.location
#   resource_group_name            = azurerm_resource_group.public.name
#   log_analytics_workspace_id     = azurerm_log_analytics_workspace.law.id
#   infrastructure_subnet_id       = azurerm_subnet.apps_forntend.id
#   internal_load_balancer_enabled = true
#   workload_profile {
#     name = "app-frontend"
#     workload_profile_type = "D4"
#     maximum_count = 2
#     minimum_count = 1
#   }
# }

# resource "azurerm_container_app" "aca_album_frontend" {
#   name                         = "aca-album-frontend"
#   container_app_environment_id = azurerm_container_app_environment.container_app_backend.id
#   resource_group_name          = azurerm_resource_group.private.name
#   revision_mode                = "Single"

#   template {
#     container {
#       name   = "aca-album-frontend"
#       image  = "ghcr.io/houssemdellai/containerapps-album-frontend:v1"
#       cpu    = 0.25
#       memory = "0.5Gi"
#     }
#   }
# }


