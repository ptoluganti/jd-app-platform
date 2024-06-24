module "go-serice" {
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

locals {
  go_service_app_role_name = "GoService.User"
}

resource "random_uuid" "go_serice_scope" {}
resource "random_uuid" "go_serice_role" {}

resource "azuread_application" "go_serice" {
  display_name = "${var.prefix}-go-serice-app"
  web {
    redirect_uris = ["https://${module.go-serice[0].ace_app_fqdn}/.auth/login/aad/callback"]
    homepage_url  = "https://${module.go-serice[0].ace_app_fqdn}"
    implicit_grant {
      id_token_issuance_enabled = true
    }
  }
  api {
    oauth2_permission_scope {
      id                         = random_uuid.go_serice_scope.result
      value                      = "user_impersonation"
      admin_consent_description  = "Allow the application to access ${module.go-serice[0].ace_app_rev_name} on behalf of the signed-in user."
      admin_consent_display_name = "Access ${module.go-serice[0].ace_app_rev_name}"
      user_consent_description   = "Allow the application to access ${module.go-serice[0].ace_app_rev_name} on your behalf."
      user_consent_display_name  = "Access ${module.go-serice[0].ace_app_rev_name}"
    }
  }
  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph

    resource_access {
      id   = "df021288-bdef-4463-88db-98f22de89214" # User.Read.All
      type = "Role"
    }
  }

  app_role {
    allowed_member_types = ["Application", "User"]
    description          = "Go Service role."
    display_name         = "Go Service role"
    id                   = random_uuid.go_serice_role.result
    enabled              = true
    value                = local.go_service_app_role_name
  }

  optional_claims {
    access_token {
      name = "groups"
    }
    id_token {
      name = "groups"
    }
    saml2_token {
      name = "groups"
    }
  }
}

resource "azuread_service_principal" "go_serice" {
  client_id                    = azuread_application.go_serice.client_id
  app_role_assignment_required = true
  feature_tags {
    enterprise = true
    gallery    = false
  }
}

resource "time_rotating" "go_serice" {
  rotation_days = 7
}

resource "azuread_application_password" "go_serice" {
  application_id = azuread_application.go_serice.id
  display_name   = "${var.prefix}-go-serice-secret"
  rotate_when_changed = {
    rotation = time_rotating.go_serice.id
  }
}
