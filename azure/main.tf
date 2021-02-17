provider "azurerm" {
    version = "2.46.1"
    features {}

}

resource "azurerm_resource_group" "lmarcus" {
    name = "lmarcus"
    location = "Japan West"
}

resource "azurerm_virtual_network" "createbyazcliVNET" {
    name = "createbyazcliVNET"
    address_space = ["10.0.0.0/16"]
    location = azurerm_resource_group.lmarcus.location
    resource_group_name = azurerm_resource_group.lmarcus.name
}

resource "azurerm_subnet" "createbyazcliSubnet" {
    name = "createbyazcliSubnet"
    resource_group_name = azurerm_resource_group.lmarcus.name
    virtual_network_name = azurerm_virtual_network.createbyazcliVNET.name
    address_prefixes = ["10.0.0.0/24"]
}

resource "azurerm_public_ip" "createbyazcliPublicIP"{
    name = "createbyazcliPublicIP"
    location = azurerm_resource_group.lmarcus.location
    resource_group_name = azurerm_resource_group.lmarcus.name
    allocation_method = "Dynamic"
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