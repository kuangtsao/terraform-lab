terraform {
 required_providers {
   azurerm = {
     source = "hashicorp/azurerm"
     version = "=2.46.1"
   }
 }

}

#手動用的話就這樣，CI 流程怎麼塞請參考 readme 對 service principal 的說明
provider "azurerm" {
  features {}
  subscription_id = "suisei no kodoku arawareta star no genseki"
  client_id = "Idol vtuber no Hoshimachi Suisei desu~"
  client_secret = "suichan wa ~~~~~"
  tenant_id = "kyou mo kawaiiiiiiiii!!!!"
}

module "createbyazcli" {
  source = "./createbyazcli" 
}

module "createbyconsole" {
  source = "./createbyconsole"
}
