resource "azurerm_resource_group" "lmarcus" {
  name     = "lmarcus"
  location = "Japan West"
}

resource "azurerm_network_security_group" "createbyconsole-nsg" {
  name                = "createbyconsole-nsg"
  location            = azurerm_resource_group.lmarcus.location
  resource_group_name = azurerm_resource_group.lmarcus.name

  security_rule {
    name                       = "SSH"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name = "http"
    priority = 310
    direction = "Inbound"
    access = "Allow"
    protocol = "TCP"
    source_port_range = "*"
    destination_port_range = "80"
    source_address_prefix = "8.8.8.8"
    destination_address_prefix = "*"
  }
}