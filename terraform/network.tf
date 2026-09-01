# ---------------------------------------------------------
# VNET 
# ---------------------------------------------------------

resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet-security-lab"
  location            = azurerm_resource_group.rg-azure-vnet-project.location
  resource_group_name = azurerm_resource_group.rg-azure-vnet-project.name
  address_space       = ["10.10.0.0/16"]
}


# ---------------------------------------------------------
# Subnets
# ---------------------------------------------------------


resource "azurerm_subnet" "web" {
  name                 = "web-subnet"
  resource_group_name  = azurerm_resource_group.rg-azure-vnet-project.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.10.1.0/24"]
}

resource "azurerm_subnet" "app" {
  name                 = "app-subnet"
  resource_group_name  = azurerm_resource_group.rg-azure-vnet-project.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.10.2.0/24"]
}

resource "azurerm_subnet" "db" {
  name                 = "db-subnet"
  resource_group_name  = azurerm_resource_group.rg-azure-vnet-project.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.10.3.0/24"]
}

