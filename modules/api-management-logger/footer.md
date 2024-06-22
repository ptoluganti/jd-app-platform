Example use:

```
module "apim_logger" {
  source = "./_tfmodules/api-management-logger"

   providers = {
    azurerm      = azurerm
    azurerm.apim = azurerm.coreapp # the azurerm provider for the apim instance
  }

  apiManagementName                     = "name of the api management instance"
  apiManagementResourceGroupName        = "name of the resource group for the api management instance"
  apmId                                 = "the apm id of the logger"
  environmentAcronym                    = "the environment acronym"
  applicationInsightsInstrumentationKey = "key for application insights"
}
```