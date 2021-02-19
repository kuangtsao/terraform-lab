provider "azurerm" {
  version = "2.46.1"
  features {}
}

module "createbyazcli" {
  source = "./createbyazcli" 
}

module "createbyconsole" {
  source = "./createbyconsole"
}
