terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.93.0"
      configuration_aliases = [
        azurerm.apim,
        azurerm.privateDns
      ]
    }
  }
}