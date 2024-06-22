
The Key Vault module can be used like so:

```
module "key-vault" {
  source = "./_modules/key-vault"

  providers = {
    azurerm                   = azurerm
    azurerm.azure_private_dns = azurerm.azure_private_dns
  }

  resourceGroupName   = resource.azurerm_resource_group.tfstate.name
  keyVaultName        = data.namep_azure_name.tfstate_kv.result
  location            = var.location
  subnetId            = module.subnets.subnets[data.namep_azure_name.tf_subnet.result].id
  privateEndpointName = data.namep_azure_name.pe_tfstate_kv.result
  tags                = local.base_tags
  tenantId            = data.azurerm_client_config.current.tenant_id
  addLocks            = var.add_locks

  depends_on = [
    module.subnets
  ]
}
```