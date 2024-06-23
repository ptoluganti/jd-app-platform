
resource "azurerm_container_app" "ca" {
  name                         = var.name
  container_app_environment_id = var.container_app_environment_id
  resource_group_name          = var.resource_group_name
  revision_mode                = try(var.revision_mode, "Single")
  workload_profile_name        = try(var.workload_profile_name, "Consumption")

  template {
    min_replicas    = 1
    # try(var.template.min_replicas, 1)
    max_replicas    = 1
    # try(var.template.max_replicas, 1)
    revision_suffix = null
    # try(var.template.revision_suffix, null)

    dynamic "init_container" {
      for_each = try(var.init_container, null) != null ? { default = var.init_container } : {}
      content {
        name    = init_container.value.name
        image   = init_container.value.image
        cpu     = try(init_container.value.cpu, 0.25)
        memory  = try(init_container.value.memory, "0.5Gi")
        command = try(init_container.value.command, [])
        args    = try(init_container.value.args, [])

        dynamic "env" {
          for_each = { for key, env in try(init_container.value.env, {}) : key => env }
          content {
            name        = env.key
            value       = try(env.value.value, null)
            secret_name = try(env.value.secret_name, null)
          }
        }

        dynamic "volume_mounts" {
          for_each = try(init_container.value.volume_mounts, null) != null ? { default = init_container.value.volume_mounts } : {}
          content {
            name = volume_mounts.value.name
            path = volume_mounts.value.path
          }
        }
      }
    }

    dynamic "container" {
      for_each = var.containers
      content {
        name    = container.key
        image   = container.value.image
        cpu     = try(container.value.cpu, 0.25)
        memory  = try(container.value.memory, "0.5Gi")
        
      }
    }

    
  }

  dynamic "ingress" {
    for_each = try(var.ingress, null) != null ? { default = var.ingress } : {}

    content {
      allow_insecure_connections = try(ingress.value.allow_insecure_connections, false)
      external_enabled           = try(ingress.value.external_enabled, false)
      fqdn                       = try(ingress.value.fqdn, null)
      target_port                = ingress.value.target_port
      exposed_port               = try(ingress.value.transport, null) == "tcp" ? ingress.value.exposed_port : null
      transport                  = try(ingress.value.transport, "auto")


      dynamic "traffic_weight" {
        ## This block only applies when revision_mode is set to Multiple.
        for_each = { for k, v in try(ingress.value.traffic_weight, null) : k => v }
        content {
          label           = try(traffic_weight.value.label, null)
          latest_revision = try(traffic_weight.value.latest_revision, true)
          percentage      = try(traffic_weight.value.percentage, 100)
          revision_suffix = try(traffic_weight.value.latest_revision, null) == false ? traffic_weight.value.revision_suffix : null
        }
      }

      dynamic "ip_security_restriction" {
        ## The action types in an all ip_security_restriction blocks must be the same for the ingress, mixing Allow and Deny rules is not currently supported by the service.
        for_each = try(ingress.value.ip_security_restriction, null) != null ? { default = ingress.value.ip_security_restriction } : {}
        content {
          name             = try(ip_security_restriction.value.name, null)
          description      = try(ip_security_restriction.value.description, null)
          action           = ip_security_restriction.value.action
          ip_address_range = ip_security_restriction.value.ip_address_range
        }
      }
    }
  }

  dynamic "registry" {
    for_each = try(var.registry_identities, {})
    content {
      server               = registry.value.server
      identity             = try(registry.value.identity_id, null)
      username             = try(registry.value.username, null)
      password_secret_name = try(registry.value.password_secret_name, null)
    }
  }

  dynamic "identity" {
    for_each = try(var.app_identities, {})

    content {
      type         = try(identity.value.type, "SystemAssigned")
      identity_ids = try(identity.value.identity_ids, [])
    }
  }

  tags = var.tags
}

# resource "azurerm_container_app_environment_certificate" "certificate" {
#   for_each = { for caec in local.custom_domain_certificates : caec.key => caec }

#   name                         = each.value.name
#   container_app_environment_id = azurerm_container_app_environment.cae.id
#   certificate_blob_base64      = try(each.value.key_vault_certificate, filebase64(each.value.path))
#   certificate_password         = each.value.password
# }

# resource "azurerm_container_app_custom_domain" "domain" {
#   for_each = { for domain in local.custom_domain_certificates : domain.key => domain }

#   name                                     = trimprefix(each.value.fqdn, "asuid.")
#   container_app_id                         = azurerm_container_app.ca[each.value.ca_name].id
#   container_app_environment_certificate_id = azurerm_container_app_environment_certificate.certificate[each.key].id
#   certificate_binding_type                 = try(each.value.binding_type, "Disabled")
# }

# resource "azurerm_user_assigned_identity" "identity" {
#   for_each = { for identity in local.user_assigned_identities : identity.uai_name => identity if contains(["UserAssigned", "SystemAssigned, UserAssigned"], identity.type) }

#   name                = each.value.uai_name
#   resource_group_name = try(each.value.resourcegroup, var.resourcegroup)
#   location            = try(each.value.location, var.location)
#   tags                = try(each.value.tags, var.environment.tags, null)
# }

# resource "azurerm_user_assigned_identity" "identity_jobs" {
#   for_each = { for identity in local.user_assigned_identities_jobs : identity.uai_name => identity if contains(["UserAssigned", "SystemAssigned, UserAssigned"], identity.type) }

#   name                = each.value.uai_name
#   resource_group_name = try(each.value.resourcegroup, var.resourcegroup)
#   location            = try(each.value.location, var.location)
#   tags                = try(each.value.tags, var.environment.tags, null)
# }

