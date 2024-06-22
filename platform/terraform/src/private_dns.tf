# locals {
#   c_p_dns_name = replace(azurerm_container_app.aca_album_backend.latest_revision_fqdn, "${azurerm_container_app.aca_album_backend.latest_revision_name}.", "")
# }

# resource "azurerm_private_dns_zone" "private_dns" {
#   name                = "dev.app.internal"
#   resource_group_name = azurerm_resource_group.private.name
# }


# resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_link" {
#   name                  = "internal-dns-link"
#   private_dns_zone_name = azurerm_private_dns_zone.private_dns.name
#   resource_group_name   = azurerm_resource_group.private.name
#   virtual_network_id    = azurerm_virtual_network.vnet.id
# }


# resource "azurerm_private_dns_zone" "c_private_dns" {
#   name                = local.c_p_dns_name
#   resource_group_name = azurerm_resource_group.private.name
# }

# resource "azurerm_private_dns_zone_virtual_network_link" "c_private_dns_link" {
#   name                  = "internal-dns-link"
#   private_dns_zone_name = azurerm_private_dns_zone.c_private_dns.name
#   resource_group_name   = azurerm_resource_group.private.name
#   virtual_network_id    = azurerm_virtual_network.vnet.id
#   registration_enabled  = true
# }

# # resource "azurerm_dns_a_record" "gateway" {
# #   name                = local.gateway_dns_prefix
# #   zone_name           = azurerm_dns_zone.dns.name
# #   resource_group_name = azurerm_resource_group.private.name
# #   ttl                 = 300
# #   records             = [ azurerm_public_ip.ip.ip_address ]
# # }

# # resource "azurerm_dns_a_record" "management" {
# #   name                = local.management_dns_prefix
# #   zone_name           = azurerm_dns_zone.dns.name
# #   resource_group_name = azurerm_resource_group.private.name
# #   ttl                 = 300
# #   records             = [ azurerm_public_ip.ip.ip_address ]
# # }

# # resource "azurerm_dns_a_record" "devportal" {
# #   name                = local.devportal_dns_prefix
# #   zone_name           = azurerm_dns_zone.dns.name
# #   resource_group_name = azurerm_resource_group.private.name
# #   ttl                 = 300
# #   records             = [ azurerm_public_ip.ip.ip_address ]
# # }

# # resource "azurerm_dns_a_record" "scm" {
# #   name                = local.scm_dns_prefix
# #   zone_name           = azurerm_dns_zone.dns.name
# #   resource_group_name = azurerm_resource_group.private.name
# #   ttl                 = 300
# #   records             = [ azurerm_public_ip.ip.ip_address ]
# # }
