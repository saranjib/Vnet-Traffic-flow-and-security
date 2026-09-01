# =========================================================
# VNET 1 -> VNET 2
# =========================================================

resource "azurerm_virtual_network_peering" "vnet1_to_vnet2" {
  name = "vnet1-to-vnet2"

  resource_group_name = azurerm_resource_group.rg-azure-vnet-project.name

  virtual_network_name = azurerm_virtual_network.vnet1.name

  remote_virtual_network_id = azurerm_virtual_network.vnet2.id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

# =========================================================
# VNET 2 -> VNET 1
# =========================================================

resource "azurerm_virtual_network_peering" "vnet2_to_vnet1" {
  name = "vnet2-to-vnet1"

  resource_group_name = azurerm_resource_group.rg-azure-vnet-project.name

  virtual_network_name = azurerm_virtual_network.vnet2.name

  remote_virtual_network_id = azurerm_virtual_network.vnet1.id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}
