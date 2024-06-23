output "ace_id" {
  value = azurerm_container_app_environment.ace.id
}

output "ace_default_domain" {
  value = azurerm_container_app_environment.ace.default_domain
}

output "ace_static_ip" {
  value = azurerm_container_app_environment.ace.static_ip_address
}