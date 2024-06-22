resource "azurerm_key_vault" "kv" {
  name                          = var.keyVaultName
  location                      = var.location
  resource_group_name           = var.resourceGroupName
  tenant_id                     = var.tenantId
  enabled_for_disk_encryption   = true
  soft_delete_retention_days    = var.softDeleteRetentionDays
  purge_protection_enabled      = true
  sku_name                      = var.skuName
  public_network_access_enabled = local.public_network_access_enabled
  enable_rbac_authorization     = var.enableRbacAuthorization

  network_acls {
    bypass                     = var.networkAcls.bypass
    default_action             = var.networkAcls.defaultAction
    ip_rules                   = local.ip_rules
    virtual_network_subnet_ids = local.virtual_network_subnet_ids
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_management_lock" "kv" {
  count = var.addLocks ? 1 : 0

  name       = "DoNotDelete"
  scope      = azurerm_key_vault.kv.id
  lock_level = "CanNotDelete"
}

locals {
  ip_rules                       = try(var.networkAcls.ipRules, [])
  has_ip_rules                   = length(local.ip_rules) != 0
  virtual_network_subnet_ids     = try(var.networkAcls.virtualNetworkSubnetIds, [])
  has_virtual_network_subnet_ids = length(local.virtual_network_subnet_ids) != 0
  public_network_access_enabled  = ((local.has_ip_rules || local.has_virtual_network_subnet_ids) && var.networkAcls.defaultAction == "Deny") || (var.networkAcls.defaultAction == "Allow")
}