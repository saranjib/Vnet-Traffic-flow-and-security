# Create a resource group
resource "azurerm_resource_group" "rg-azure-vnet-project" {
  name     = var.resource_group_name
  location = var.location
}
