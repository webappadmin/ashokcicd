resource "azurerm_virtual_network" "this" {
  name                = var.vnet.name
  address_space       = var.vnet.address_space
  location            = var.vnet.location
  resource_group_name = var.vnet.resource_group
}

resource "azurerm_subnet" "this" {
  name                 = var.vnet.subnet_name
  resource_group_name  = var.vnet.resource_group
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = var.vnet.subnet_prefix
}

resource "azurerm_network_security_group" "this" {
  name                = var.vnet.nsg_name
  location            = var.vnet.location
  resource_group_name = var.vnet.resource_group

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  # -------------------------
  # Allow Jenkins (8080)
  # -------------------------
  security_rule {
    name                       = "Allow-Jenkins-8080"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "this" {
  subnet_id                 = azurerm_subnet.this.id
  network_security_group_id = azurerm_network_security_group.this.id
}

output "subnet_id" {
  value = azurerm_subnet.this.id
}
