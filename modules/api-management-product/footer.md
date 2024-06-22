Example use:

```
module "apim_dibi_product_sub" {
  source = "./_tfmodules/api-management-product"

  count = var.deploy_to_apim_02 == true ? 1 : 0

   providers = {
    azurerm      = azurerm
    azurerm.apim = azurerm.coreapp # the azurerm provider for the apim instance
  }

  apiManagementName                     = "name of the api management instance"
  apiManagementResourceGroupName        = "name of the resource group for the api management instance"

  productId            = "the product id"
  productDisplayName   = "the product display name"
  productDescription   = "the product description"
  subscriptionRequired = true # whether or not a subscription key is required to access the API (false means an 'open' product)
  subscriptionNames    = ["subscription one", "subscription two"]
}
```