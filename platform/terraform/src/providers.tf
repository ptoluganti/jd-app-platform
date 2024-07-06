terraform {
  required_version = ">= 1"

  # backend "azurerm" {
  #   environment = "public"
  # }

  required_providers {
    azurerm = {
      version = "~> 3"
    }

    # acme = {
    #   source  = "vancluever/acme"
    #   version = "~> 2"
    # }

    # tls = {
    #   source  = "hashicorp/tls"
    #   version = "~> 3"
    # }

    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2"
    }
  }
}

provider "azurerm" {

  features {
    key_vault {
      purge_soft_delete_on_destroy    = false
      recover_soft_deleted_key_vaults = false
    }
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

# provider "acme" {
#   server_url = "https://acme-staging-v02.api.letsencrypt.org/directory"
# }

# provider "tls" {

# }
