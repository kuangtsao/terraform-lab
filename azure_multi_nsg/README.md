# azure_multi_nsg

未完成事項：把 security rule 用 resource 的方式拆掉

## 導入指令
```
 terraform import module.createbyazcli.azurerm_resource_group.lmarcus /subscriptions/[你的 subscription ID]/resourceGroups/lmarcus
 
 terraform import module.createbyconsole.azurerm_resource_group.lmarcus /subscriptions/[你的 subscription ID]/resourceGroups/lmarcus
 
 terraform import module.createbyazcli.azurerm_network_security_group.createbyazcliNSG /subscriptions/[你的 subscription ID]/resourceGroups/lmarcus/providers/Microsoft.Network/networkSecurityGroups/createbyazcliNSG
 
 terraform import module.createbyconsole.azurerm_network_security_group.createbyconsole-nsg /subscriptions/[你的 subscription ID]/resourceGroups/lmarcus/providers/Microsoft.Network/networkSecurityGroups/createbyconsole-nsg
```