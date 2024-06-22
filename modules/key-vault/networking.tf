resource "azurerm_private_endpoint" "pe_kv" {
  name                          = var.privateEndpointName
  location                      = var.location
  resource_group_name           = var.resourceGroupName
  subnet_id                     = var.subnetId
  custom_network_interface_name = "${var.privateEndpointName}-nic"

  private_service_connection {
    name                           = "${var.privateEndpointName}-psc"
    private_connection_resource_id = azurerm_key_vault.kv.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }

  lifecycle {
    ignore_changes = [private_dns_zone_group, tags]
  }
}

data "azurerm_network_interface" "pe_kv" {
  name                = "${var.privateEndpointName}-nic"
  resource_group_name = var.resourceGroupName

  depends_on = [
    azurerm_private_endpoint.pe_kv
  ]
}

resource "azurerm_private_dns_a_record" "pe_kv" {
  provider            = azurerm.azure_private_dns
  name                = var.keyVaultName
  zone_name           = "privatelink.vaultcore.azure.net"
  resource_group_name = var.privateDnsResourceGroupName
  ttl                 = 300
  records             = [data.azurerm_network_interface.pe_kv.private_ip_address]
}