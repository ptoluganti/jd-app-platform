Example use:

```
module "some_api" {
  source = "./_tfmodules/api-management-api"

  providers = {
    azurerm      = azurerm
    azurerm.apim = azurerm.coreapp
  }

  apiManagement = {
    name              = "name of the api management instance"
    resourceGroupName = "name of the resource group for the api management instance"
    loggerId          = "the id of the APIM logger to use for the API"
  }

  apmId                          = "apm_id"
  name                           = "api_name"
  apiEnvironment                 = "dev"
  apiPathSuffix                  = "-hub"
  customDomainHost               = "somapi.api.internal.msreinsurance.com"
  customDomainPrivateDnsZoneName = "api.internal.msreinsurance.com"
  versions = [
    {
      version     = "1.0"
      specContent = "..."
      specFormat  = "openapi/json"
    }
  ]
  apimProductIds     = ["product-one", "product-two"]
  policyTemplateFile = "path to policy template file to be applied to the API"
}
```