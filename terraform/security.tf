# ---------------------------------------------------------
# Network Security Groups
# ---------------------------------------------------------


resource "azurerm_network_security_group" "web" {
  name                = "nsg-web"
  location            = azurerm_resource_group.rg-azure-vnet-project.location
  resource_group_name = azurerm_resource_group.rg-azure-vnet-project.name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.admin_ip
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-HTTP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-HTTPS"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "app" {
  name                = "nsg-app"
  location            = azurerm_resource_group.rg-azure-vnet-project.location
  resource_group_name = azurerm_resource_group.rg-azure-vnet-project.name

  security_rule {
    name                       = "Allow-App-From-Web"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "10.10.1.0/24"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-SSH-From-Web"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "10.10.1.0/24"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "db" {
  name                = "nsg-db"
  location            = azurerm_resource_group.rg-azure-vnet-project.location
  resource_group_name = azurerm_resource_group.rg-azure-vnet-project.name

  security_rule {
    name                       = "Allow-DB-From-App"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1433"
    source_address_prefix      = "10.10.2.0/24"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-SSH-From-Web"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "10.10.1.0/24"
    destination_address_prefix = "*"
  }
}

# ---------------------------------------------------------
# Associate NSGs with Subnets
# ---------------------------------------------------------

resource "azurerm_subnet_network_security_group_association" "web" {
  subnet_id                 = azurerm_subnet.web.id
  network_security_group_id = azurerm_network_security_group.web.id
}

resource "azurerm_subnet_network_security_group_association" "app" {
  subnet_id                 = azurerm_subnet.app.id
  network_security_group_id = azurerm_network_security_group.app.id
}

resource "azurerm_subnet_network_security_group_association" "db" {
  subnet_id                 = azurerm_subnet.db.id
  network_security_group_id = azurerm_network_security_group.db.id
}

# ---------------------------------------------------------
# Route Table
# ---------------------------------------------------------

resource "azurerm_route_table" "app" {
  name                = "rt-app"
  location            = azurerm_resource_group.rg-azure-vnet-project.location
  resource_group_name = azurerm_resource_group.rg-azure-vnet-project.name

  # Example route for the lab.
  # Replace the next hop with an actual firewall/NVA
  # when extending the project.
  route {
    name                   = "db-network"
    address_prefix         = "10.10.3.0/24"
    next_hop_type          = "VnetLocal"
  }
}

resource "azurerm_subnet_route_table_association" "app" {
  subnet_id      = azurerm_subnet.app.id
  route_table_id = azurerm_route_table.app.id
}
