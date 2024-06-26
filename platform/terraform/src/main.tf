
data "azurerm_client_config" "current" {}

resource "azurerm_public_ip" "bastion_pip" {
  name                = "bastion_pip"
  location            = azurerm_resource_group.mgt.location
  resource_group_name = azurerm_resource_group.mgt.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion_host" {
  name                = "${var.prefix}-bastion"
  location            = azurerm_resource_group.mgt.location
  resource_group_name = azurerm_resource_group.mgt.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = module.network.snet_bastion
    public_ip_address_id = azurerm_public_ip.bastion_pip.id
  }
}

# resource "azurerm_log_analytics_workspace" "law" {
#   name                = "${var.prefix}-law-01"
#   location            = azurerm_resource_group.private.location
#   resource_group_name = azurerm_resource_group.private.name
#   sku                 = "PerGB2018"
#   retention_in_days   = 30
# }

module "network" {
  depends_on          = []
  source              = "./modules/network"
  location            = azurerm_resource_group.network.location
  resource_group_name = azurerm_resource_group.network.name
  prefix              = var.prefix
}

module "jumpbox" {
  count               = 1
  depends_on          = []
  source              = "./modules/windows_vm"
  location            = azurerm_resource_group.mgt.location
  resource_group_name = azurerm_resource_group.mgt.name
  prefix              = var.prefix
  subnet_id           = module.network.snet_mgt
}

module "ace" {
  count                          = 1
  depends_on                     = []
  source                         = "./modules/ace"
  location                       = var.location
  resource_group_name            = azurerm_resource_group.private.name
  prefix                         = var.prefix
  internal_load_balancer_enabled = true
  # log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id
  infrastructure_subnet_id = module.network.snet_backend
  workload_profile = {
    app_backend = {
      name                  = "app-backend"
      workload_profile_type = "D4"
      maximum_count         = 2
      minimum_count         = 1
    }
  }
}

resource "azurerm_private_dns_zone" "ace_dnszone" {
  name                = module.ace[0].ace_default_domain
  resource_group_name = azurerm_resource_group.private.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "ace_network_link" {
  resource_group_name   = azurerm_resource_group.private.name
  name                  = "${var.prefix}-link"
  private_dns_zone_name = azurerm_private_dns_zone.ace_dnszone.name
  virtual_network_id    = module.network.vnet
  registration_enabled  = true
}

resource "azurerm_private_dns_a_record" "ace_dns_a_record" {
  name                = "*"
  zone_name           = azurerm_private_dns_zone.ace_dnszone.name
  resource_group_name = azurerm_resource_group.private.name
  ttl                 = 300
  records             = [module.ace[0].ace_static_ip]
}


