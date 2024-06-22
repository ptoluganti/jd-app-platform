output "snet_backend" {
  value = azurerm_subnet.apps_backend.id
}

output "snet_mgt" {
  value = azurerm_subnet.mgt.id
}

output "snet_bastion" {
  value = azurerm_subnet.bastion.id
}

output "snet_apim" {
  value = azurerm_subnet.apim.id
}

output "snet_frontend" {
  value = azurerm_subnet.apps_forntend.id
}

output "vnet" {
  value = azurerm_virtual_network.vnet.id
}
