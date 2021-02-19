resource "azurerm_resource_group" "lmarcus" {
  name     = "lmarcus"
  location = "Japan West"
}

resource "azurerm_network_security_group" "createbyazcliNSG" {
  name                = "createbyazcliNSG"
  location            = azurerm_resource_group.lmarcus.location
  resource_group_name = azurerm_resource_group.lmarcus.name

  security_rule {
    name                       = "default-allow-ssh"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}