data "azurerm_private_dns_zone" "core_pdns" {
  provider            = azurerm.privateDns
  name                = var.customDomain.privateDnsZone.name
  resource_group_name = var.customDomain.privateDnsZone.resourceGroupName
}

resource "azurerm_private_dns_a_record" "capp_dns_arecord_01" {
  provider            = azurerm.privateDns
  name                = var.customDomain.host
  zone_name           = data.azurerm_private_dns_zone.core_pdns.name
  resource_group_name = var.customDomain.privateDnsZone.resourceGroupName
  ttl                 = 3600
  records             = [var.containerAppEnvironment.staticIpAddress]

  lifecycle {
    ignore_changes = [tags]
  }
}