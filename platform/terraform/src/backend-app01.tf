module "ace_app" {
  count                        = 1
  source                       = "./modules/ace_apps"
  container_app_environment_id = module.ace[0].ace_id
  resource_group_name          = azurerm_resource_group.private.name
  workload_profile_name        = "app-backend"
  name                         = "go-serice"
  ingress = {
    external_enabled = true
    target_port      = 8080
    transport        = "auto"
    traffic_weight = {
      default = {
        latest_revision = true
        percentage      = 100
      }
    }

  }
  app_identities = {
    app-backend = {
      identity_ids = []
      type         = "SystemAssigned"
    }
  }
  containers = {
    go-service = {
      image                  = "mcr.microsoft.com/dotnet/samples:aspnetapp"
      cpu                    = "0.5"
      memory                 = "1Gi"
      azure_queue_scale_rule = null
    }
  }
}
