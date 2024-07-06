output "keyvault" {
  value = {
    id   = azurerm_key_vault.main.id
    name = azurerm_key_vault.main.name
  }
}
