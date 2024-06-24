output "ace_app_rev_name" {
  # sensitive = true
  value = azurerm_container_app.ca.latest_revision_name
}

output "ace_app_fqdn" {
  # sensitive = true
  value = azurerm_container_app.ca.latest_revision_fqdn
}
