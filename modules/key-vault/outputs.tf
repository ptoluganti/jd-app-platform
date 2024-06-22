output "name" {
  value       = azurerm_key_vault.kv.name
  description = "The name of the Key Vault"
}

output "id" {
  value       = azurerm_key_vault.kv.id
  description = "The Id of the Key Vault"
}

output "resourceGroupName" {
  value       = var.resourceGroupName
  description = "The Resource Group of the Key Vault"
}