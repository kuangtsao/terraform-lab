provider "azurerm" {
  version = "2.46.1"
  features {}

}

resource "azurerm_resource_group" "lmarcus" {
  name     = "lmarcus"
  location = "Japan West"
}

resource "azurerm_virtual_network" "createbyazcliVNET" {
  name                = "createbyazcliVNET"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.lmarcus.location
  resource_group_name = azurerm_resource_group.lmarcus.name
}

resource "azurerm_subnet" "createbyazcliSubnet" {
  name                 = "createbyazcliSubnet"
  resource_group_name  = azurerm_resource_group.lmarcus.name
  virtual_network_name = azurerm_virtual_network.createbyazcliVNET.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_public_ip" "createbyazcliPublicIP" {
  name                = "createbyazcliPublicIP"
  location            = azurerm_resource_group.lmarcus.location
  resource_group_name = azurerm_resource_group.lmarcus.name
  allocation_method   = "Dynamic"
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

resource "azurerm_network_interface" "createbyazcliVMNic" {
  name                = "createbyazcliVMNic"
  location            = azurerm_resource_group.lmarcus.location
  resource_group_name = azurerm_resource_group.lmarcus.name

  ip_configuration {
    name                          = "ipconfigcreatebyazcli"
    subnet_id                     = azurerm_subnet.createbyazcliSubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.createbyazcliPublicIP.id
  }
}

resource "azurerm_network_interface_security_group_association" "createbyazcliVMNic_NSG_association" {
  network_interface_id      = azurerm_network_interface.createbyazcliVMNic.id
  network_security_group_id = azurerm_network_security_group.createbyazcliNSG.id
}

resource "azurerm_linux_virtual_machine" "createbyazcli" {
  name                  = "createbyazcli"
  location              = azurerm_resource_group.lmarcus.location
  resource_group_name   = azurerm_resource_group.lmarcus.name
  network_interface_ids = [azurerm_network_interface.createbyazcliVMNic.id]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "createbyazcli_disk1_80eec4db622e4c6da8b14ffdbb660397"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = "createbyazcli"
  admin_username                  = "lmarcus"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "lmarcus"
    public_key = file("~/.ssh/id_rsa.pub")
  }
}