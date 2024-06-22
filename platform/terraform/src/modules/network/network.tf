
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "ingress" {
  name                 = "ingress-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "apim" {
  name                 = "apim-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "apps_backend" {
  name                 = "apps-backend-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.4.0/23"]
  delegation {
    name = "core-backend-appsenv"
    service_delegation {
      name    = "Microsoft.App/environments"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

resource "azurerm_subnet" "apps_forntend" {
  name                 = "apps-frontend-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.6.0/23"]
  delegation {
    name = "core-frontned-appsenv"
    service_delegation {
      name    = "Microsoft.App/environments"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "vm_nsg_association" {
  subnet_id                 = azurerm_subnet.ingress.id
  network_security_group_id = azurerm_network_security_group.vm_nsg.id
}



# Create Network Security Group and rules
resource "azurerm_network_security_group" "vm_nsg" {
  name                = "vm-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "RDP"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "web"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
# resource "azurerm_subnet" "bastion" {
#   name                 = "bastion-subnet"
#   resource_group_name  = azurerm_resource_group.apim.name
#   virtual_network_name = azurerm_virtual_network.vnet.name
#   address_prefixes     = ["10.0.10.0/24"]
# 
# delegation {
#   name = "aci-subnet-delegation"

#   service_delegation {
#     name    = "Microsoft.ContainerInstance/containerGroups"
#     actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
#   }
# }
# }

# resource "azurerm_private_dns_zone" "apimdns" {
#   name                = "azure-api.net"
#   resource_group_name = azurerm_resource_group.apim.name
# }

# resource "azurerm_private_dns_zone_virtual_network_link" "apimdnsvnetlink" {
#   name                  = "apimdnsvnetlink"
#   resource_group_name   = azurerm_resource_group.apim.name
#   private_dns_zone_name = azurerm_private_dns_zone.apimdns.name
#   virtual_network_id    = azurerm_virtual_network.vnet.id
# }

resource "azurerm_subnet_network_security_group_association" "apim_nsg_association" {
  subnet_id                 = azurerm_subnet.apim.id
  network_security_group_id = azurerm_network_security_group.apim_nsg.id
}

# STV2 MIGRATION: NSG should have all the rules required for stv2
# This illustration is for internal network model. Refer https://learn.microsoft.com/en-us/azure/api-management/api-management-using-with-internal-vnet?tabs=stv2#configure-nsg-rules
resource "azurerm_network_security_group" "apim_nsg" {
  name                = "apim-subnet-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name


  security_rule {
    name                       = "AllowApimVnetInbound"
    priority                   = 2000
    protocol                   = "Tcp"
    destination_port_range     = "3443"
    access                     = "Allow"
    direction                  = "Inbound"
    source_port_range          = "*"
    source_address_prefix      = "ApiManagement"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "apim-azure-infra-lb"
    priority                   = 2010
    protocol                   = "Tcp"
    destination_port_range     = "6390"
    access                     = "Allow"
    direction                  = "Inbound"
    source_port_range          = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "apim-azure-storage"
    priority                   = 2000
    protocol                   = "Tcp"
    destination_port_range     = "443"
    access                     = "Allow"
    direction                  = "Outbound"
    source_port_range          = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "Storage"
  }

  security_rule {
    name                       = "apim-azure-sql"
    priority                   = 2010
    protocol                   = "Tcp"
    destination_port_range     = "1443"
    access                     = "Allow"
    direction                  = "Outbound"
    source_port_range          = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "SQL"
  }

  security_rule {
    name                       = "apim-azure-kv"
    priority                   = 2020
    protocol                   = "Tcp"
    destination_port_range     = "443"
    access                     = "Allow"
    direction                  = "Outbound"
    source_port_range          = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "AzureKeyVault"
  }
}

# resource "azurerm_subnet_route_table_association" "apim" {
#   subnet_id = azurerm_subnet.example.id
#   route_table_id = azurerm_route_table.apim_snnsg_nsg.id
# }
