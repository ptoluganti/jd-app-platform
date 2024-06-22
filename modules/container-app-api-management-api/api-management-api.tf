module "api_management_api" {
  source = "../api-management-api"

  providers = {
    azurerm      = azurerm
    azurerm.apim = azurerm.apim
  }

  apiManagement                  = var.apiManagement
  apmId                          = var.apmId
  name                           = var.name
  apiEnvironment                 = var.apiEnvironment
  apiPathSuffix                  = var.apiPathSuffix
  customDomainHost               = var.customDomainHost
  customDomainPrivateDnsZoneName = var.customDomainPrivateDnsZoneName
  versions                       = var.versions
  policyTemplateFile             = var.policyTemplateFile
  apimProductIds                 = var.apimProductIds
  assetBasePath                  = var.assetBasePath

  depends_on = [module.container_app]
}