output "snet_backend" {
  value = azurerm_subnet.apps_backend.id
}

output "vnet" {
  value = azurerm_virtual_network.vnet.id
}
