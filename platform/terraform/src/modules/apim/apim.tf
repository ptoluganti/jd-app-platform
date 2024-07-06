# https://techcommunity.microsoft.com/t5/fasttrack-for-azure/azure-api-management-stv1-to-stv2-migration-using-terraform/ba-p/4086940

resource "azurerm_api_management" "apim" {
  name                 = var.prefix
  resource_group_name  = var.resource_group_name
  location             = var.location
  publisher_name       = var.contact_name
  publisher_email      = var.contact_email
  sku_name             = "Developer_1"
  virtual_network_type = "Internal"
  min_api_version      = "2021-08-01"

  # identity {
  #   type = "SystemAssigned"
  # }

  # identity {
  #   type = "UserAssigned"
  #   identity_ids = [  
  #     azurerm_user_assigned_identity.msi.id
  #   ]
  # }
  # public_ip_address_id = azurerm_public_ip.ip.id

  virtual_network_configuration {
    subnet_id = var.subnet_id
  }

  tags = {}
}

# resource "azurerm_api_management_custom_domain" "apimdomain" {
#   api_management_id = azurerm_api_management.apim.id

#   management {
#     # key_vault_id = azurerm_key_vault_certificate.cert.secret_id
#     key_vault_id = "https://${azurerm_key_vault.kv.name}.vault.azure.net/secrets/${azurerm_key_vault_certificate.cert.name}"
#     host_name    = local.apim_management_dns_name
#   }

#   gateway {
#     # key_vault_id = azurerm_key_vault_certificate.cert.secret_id
#     key_vault_id = "https://${azurerm_key_vault.kv.name}.vault.azure.net/secrets/${azurerm_key_vault_certificate.cert.name}"
#     host_name    = local.apim_gateway_dns_name
#     # default_ssl_binding = true
#   }

#   developer_portal {
#     # key_vault_id = azurerm_key_vault_certificate.cert.secret_id
#     key_vault_id = "https://${azurerm_key_vault.kv.name}.vault.azure.net/secrets/${azurerm_key_vault_certificate.cert.name}"
#     host_name = local.apim_devportal_dns_name
#   }

#   scm {
#     # key_vault_id = azurerm_key_vault_certificate.cert.secret_id
#     key_vault_id = "https://${azurerm_key_vault.kv.name}.vault.azure.net/secrets/${azurerm_key_vault_certificate.cert.name}"
#     host_name = local.apim_scm_dns_name
#   }
# }
