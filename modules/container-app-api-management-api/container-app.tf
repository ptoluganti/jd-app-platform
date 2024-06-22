module "container_app" {
  source = "../container-app"

  providers = {
    azurerm            = azurerm
    azurerm.privateDns = azurerm.privateDns
  }

  apmId                               = var.apmId
  containerAppName                    = var.containerAppName
  region                              = var.region
  environmentAcronym                  = var.environmentAcronym
  acrLoginServer                      = var.acrLoginServer
  containerName                       = var.containerName
  containerImageName                  = var.containerImageName
  containerAppManagedIdentity         = var.containerAppManagedIdentity
  apiManagementSubnetCidr             = var.apiManagementSubnetCidr
  apiManagement02SubnetCidr           = var.apiManagement02SubnetCidr
  applicationInsightsConnectionString = var.applicationInsightsConnectionString
  containerAppEnvironment             = var.containerAppEnvironment
  customDomain                        = var.customDomain
  sku                                 = var.sku
  containerSecrets                    = var.containerSecrets
  containerEnvironmentVariables       = var.containerEnvironmentVariables
  minReplicas                         = var.minReplicas
  maxReplicas                         = var.maxReplicas
  revisionMode                        = var.revisionMode
}