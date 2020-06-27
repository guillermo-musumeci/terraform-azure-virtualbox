####################
## Network - Main ##
####################

# Create a resource group for core
resource "azurerm_resource_group" "network-rg" {
  name     = "${var.company}-rg"
  location = var.location
  tags = {
    environment = var.environment
  }
}

# Create the VNET
resource "azurerm_virtual_network" "network-vnet" {
  name                = "${var.company}-vnet"
  address_space       = [var.vnet-cidr]
  resource_group_name = azurerm_resource_group.network-rg.name
  location            = azurerm_resource_group.network-rg.location
  tags = {
    environment = var.environment
  }
}

# Create a subnet
resource "azurerm_subnet" "network-subnet" {
  name                      = "${var.company}-subnet"
  address_prefixes          = [var.subnet-cidr]
  virtual_network_name      = azurerm_virtual_network.network-vnet.name
  resource_group_name       = azurerm_resource_group.network-rg.name
}
