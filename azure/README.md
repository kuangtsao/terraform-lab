# Azure

## 流程

1. az account list --output table  

取得 subscription ID  

2. az resource list --query [].[type,id]  

查看利用 azure cli 後，出現多少東西  

```
[
  [
    "Microsoft.Compute/disks",
    "/subscriptions/[你的 subscription ID]/resourceGroups/LMARCUS/providers/Microsoft.Compute/disks/createbyazcli_disk1_80eec4db622e4c6da8b14ffdbb660397"
  ],
  [
    "Microsoft.Compute/virtualMachines",
    "/subscriptions/[你的 subscription ID]/resourceGroups/lmarcus/providers/Microsoft.Compute/virtualMachines/createbyazcli"
  ],
  [
    "Microsoft.Network/networkInterfaces",
    "/subscriptions/[你的 subscription ID]/resourceGroups/lmarcus/providers/Microsoft.Network/networkInterfaces/createbyazcliVMNic"
  ],
  [
    "Microsoft.Network/networkSecurityGroups",
    "/subscriptions/[你的 subscription ID]/resourceGroups/lmarcus/providers/Microsoft.Network/networkSecurityGroups/createbyazcliNSG"
  ],
  [
    "Microsoft.Network/publicIPAddresses",
    "/subscriptions/[你的 subscription ID]/resourceGroups/lmarcus/providers/Microsoft.Network/publicIPAddresses/createbyazcliPublicIP"
  ],
  [
    "Microsoft.Network/virtualNetworks",
    "/subscriptions/[你的 subscription ID]/resourceGroups/lmarcus/providers/Microsoft.Network/virtualNetworks/createbyazcliVNET"
  ]
]
```

3. 查 microsoft 的文件與 terraform azure 的文件，慢慢寫 `main.tf` 以及 `terraform import`，用 `terraform plan` 來查看是否正確  

[MicroSoft terraform 連結](https://docs.microsoft.com/zh-tw/azure/developer/terraform/create-linux-virtual-machine-with-infrastructure)

```
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
terraform import azurerm_resource_group.lmarcus /subscriptions/[你的 subscription ID]/resourceGroups/lmarcus

https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
terraform import azurerm_virtual_network.createbyazcliVNET /subscriptions/[你的 subscription ID]/resourceGroups/lmarcus/providers/Microsoft.Network/virtualNetworks/createbyazcliVNET

https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
az network vnet subnet list --resource-group lmarcus --vnet-name createbyazcliVNET
terraform import azurerm_subnet.createbyazcliSubnet /subscriptions/[你的 subscription ID]/resourceGroups/lmarcus/providers/Microsoft.Network/virtualNetworks/createbyazcliVNET/subnets/createbyazcliSubnet
(terraform 不會主動顯示沒有寫到，跑 terraform plan 不會顯示 destroy ;沒有先 import 的話，即使在 main.tf 上輸入正確的設定，terraform plan 後還是會顯示新增)

https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip
terraform import azurerm_public_ip.createbyazcliPublicIP /subscriptions/[你的 subscription ID]/resourceGroups/lmarcus/providers/Microsoft.Network/publicIPAddresses/createbyazcliPublicIP

https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group
terraform import azurerm_network_security_group.createbyazcliNSG /subscriptions/[你的 subscription ID]/resourceGroups/lmarcus/providers/Microsoft.Network/networkSecurityGroups/createbyazcliNSG
(azure console 會有選擇「服務」的選項，而 terraform 是沒有的，往下看通訊協定(protocol)和目的地連接埠(destination_port_range)去作設定)

https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface
terraform import azurerm_network_interface.createbyazcliVMNic /subscriptions/[你的 subscription ID]/resourceGroups/lmarcus/providers/Microsoft.Network/networkInterfaces/createbyazcliVMNic

https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association
terraform import azurerm_network_interface_security_group_association.createbyazcliVMNic_NSG_association "/subscriptions/[你的 subscription ID]/resourceGroups/lmarcus/providers/microsoft.network/networkInterfaces/createbyazcliVMNic|/subscriptions/[你的 subscription ID]/resourceGroups/group1/providers/Microsoft.Network/networkSecurityGroups/createbyazcliNSG"

https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine
terraform import azurerm_linux_virtual_machine.createbyazcli /subscriptions/[你的 subscription ID]/resourceGroups/lmarcus/providers/Microsoft.Compute/virtualMachines/createbyazcli
```

## 結論
雖然是做到 vm 那邊就結束了，但不確定是否 OS disk 這樣算不算過，可能還會需要一點研究。