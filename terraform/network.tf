# ---------------------------------------------------------
# VNET 1
# ---------------------------------------------------------

resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet-project-01"
  location            = azurerm_resource_group.rg-azure-vnet-project.location
  resource_group_name = azurerm_resource_group.rg-azure-vnet-project.name

  address_space = ["10.0.0.0/16"]
}

# Public subnet

resource "azurerm_subnet" "public" {
  name                 = "public-subnet"
  resource_group_name  = azurerm_resource_group.rg-azure-vnet-project.name
  virtual_network_name = azurerm_virtual_network.vnet1.name

  address_prefixes = ["10.0.1.0/24"]
}

# Private subnet

resource "azurerm_subnet" "private" {
  name                 = "private-subnet"
  resource_group_name  = azurerm_resource_group.rg-azure-vnet-project.name
  virtual_network_name = azurerm_virtual_network.vnet1.name

  address_prefixes = ["10.0.2.0/24"]

  private_endpoint_network_policies = "Disabled"
}

# ---------------------------------------------------------
# VNET 2 - Used for VNet Peering
# ---------------------------------------------------------

resource "azurerm_virtual_network" "vnet2" {
  name                = "vnet-project-02"
  location            = azurerm_resource_group.rg-azure-vnet-project.location
  resource_group_name = azurerm_resource_group.rg-azure-vnet-project.name

  address_space = ["10.1.0.0/16"]

}

resource "azurerm_subnet" "vnet2_private" {
  name                 = "private-subnet"
  resource_group_name  = azurerm_resource_group.rg-azure-vnet-project.name
  virtual_network_name = azurerm_virtual_network.vnet2.name

  address_prefixes = ["10.1.1.0/24"]
}


  
