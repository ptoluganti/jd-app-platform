# resource "azurerm_key_vault" "kv" {
#   name                = "${var.prefix}-kv"
#   resource_group_name = azurerm_resource_group.private.name
#   location            = azurerm_resource_group.private.location
#   tenant_id = data.azurerm_client_config.current.tenant_id
#   sku_name  = "standard"
#   enabled_for_deployment = true
#   enabled_for_disk_encryption = true
#   enabled_for_template_deployment = true
#   enable_rbac_authorization = true
# }

# resource "azurerm_role_assignment" "this" {
#   scope                = azurerm_key_vault.kv.id
#   role_definition_name = "Key Vault Administrator"
#   principal_id         = data.azurerm_client_config.current.object_id
# }

# resource "azurerm_role_assignment" "apim" {
#   scope                = azurerm_key_vault.kv.id
#   role_definition_name = "Key Vault Secrets User"
#   principal_id         = azurerm_api_management.apim.identity[0].principal_id
# }

# # # resource "azurerm_role_assignment" "appgwmsi" {
# # #   scope                = azurerm_key_vault.kv.id
# # #   role_definition_name = "Key Vault Secrets User"
# # #   principal_id         = azurerm_user_assigned_identity.appgwmsi.principal_id
# # # }

# # # resource "azurerm_key_vault_secret" "demo" {
# # #   name         = "app-registration-client-secret"
# # #   value        = azuread_application_password.function_private.value
# # #   key_vault_id = azurerm_key_vault.kv.id
# # # }


# # /*
# # resource "azurerm_key_vault_certificate" "cert" {
# #   name         = "${var.base_name}-cert"
# #   key_vault_id = azurerm_key_vault.kv.id

# #   certificate_policy {
# #     issuer_parameters {
# #       name = "Self"
# #     }

# #     key_properties {
# #       exportable = true
# #       key_size   = 2048
# #       key_type   = "RSA"
# #       reuse_key  = true
# #     }

# #     lifetime_action {
# #       action {
# #         action_type = "AutoRenew"
# #       }

# #       trigger {
# #         days_before_expiry = 30
# #       }
# #     }

# #     secret_properties {
# #       content_type = "application/x-pkcs12"
# #     }

# #     x509_certificate_properties {
# #       # Server Authentication = 1.3.6.1.5.5.7.3.1
# #       # Client Authentication = 1.3.6.1.5.5.7.3.2
# #       extended_key_usage = ["1.3.6.1.5.5.7.3.1","1.3.6.1.5.5.7.3.2"]

# #       key_usage = [
# #         "cRLSign",
# #         "dataEncipherment",
# #         "digitalSignature",
# #         "keyAgreement",
# #         "keyCertSign",
# #         "keyEncipherment",
# #       ]

# #       subject_alternative_names {
# #         dns_names = [
# #             local.apim_gateway_dns_name,
# #             local.apim_management_dns_name,
# #             local.apim_devportal_dns_name,
# #             local.apim_scm_dns_name
# #         ]
# #       }

# #       subject            = "CN=${var.root_dns_name}"
# #       validity_in_months = 12
# #     }
# #   }
# # }
# # */
