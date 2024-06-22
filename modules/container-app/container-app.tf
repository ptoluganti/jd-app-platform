data "azurerm_container_app_environment_certificate" "msreinternal" {
  name                         = var.containerAppEnvironment.customDomainCertificateName
  container_app_environment_id = var.containerAppEnvironment.id
}

resource "azurerm_container_app" "api" {
  name                         = var.containerAppName
  container_app_environment_id = var.containerAppEnvironment.id
  resource_group_name          = var.containerAppEnvironment.resourceGroupName
  revision_mode                = "Single"

  registry {
    server   = var.acrLoginServer
    identity = var.containerAppManagedIdentity
  }

  dynamic "secret" {
    for_each = var.containerSecrets
    content {
      name  = secret.value["name"]
      value = secret.value["value"]
    }
  }

  template {
    container {
      name   = var.containerName
      image  = "${var.acrLoginServer}/${local.acr_repo_name}/${var.containerImageName}"
      cpu    = var.sku.cpu
      memory = var.sku.memory

      dynamic "env" {
        for_each = var.containerEnvironmentVariables
        content {
          name        = env.value["name"]
          value       = env.value["value"]
          secret_name = env.value["secretName"]
        }
      }
    }

    max_replicas = var.minReplicas
    min_replicas = var.maxReplicas
  }

  ingress {
    target_port                = 5000
    allow_insecure_connections = false
    external_enabled           = true

    custom_domain {
      certificate_binding_type = "SniEnabled"
      certificate_id           = data.azurerm_container_app_environment_certificate.msreinternal.id
      name                     = "${var.customDomain.host}.${var.customDomain.privateDnsZone.name}"
    }

    traffic_weight {
      percentage = 100
      # See https://github.com/hashicorp/terraform-provider-azurerm/issues/20435.
      latest_revision = true
    }

    dynamic "ip_security_restriction" {
      for_each = local.allowed_ingress_rules
      content {
        action           = "Allow"
        name             = ip_security_restriction.value.name
        ip_address_range = ip_security_restriction.value.ip_address_range
      }
    }
  }

  identity {
    type         = "UserAssigned"
    identity_ids = concat([var.containerAppManagedIdentity], var.additionalUserAssignedIdentities)
  }

  lifecycle {
    ignore_changes = [tags]
  }
}