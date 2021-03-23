# azure_multi_nsg

未完成事項：把 security rule 用 resource 的方式拆掉

## 導入指令
```
 terraform import module.createbyazcli.azurerm_resource_group.lmarcus /subscriptions/[你的 subscription ID]/resourceGroups/lmarcus
 
 terraform import module.createbyconsole.azurerm_resource_group.lmarcus /subscriptions/[你的 subscription ID]/resourceGroups/lmarcus
 
 terraform import module.createbyazcli.azurerm_network_security_group.createbyazcliNSG /subscriptions/[你的 subscription ID]/resourceGroups/lmarcus/providers/Microsoft.Network/networkSecurityGroups/createbyazcliNSG
 
 terraform import module.createbyconsole.azurerm_network_security_group.createbyconsole-nsg /subscriptions/[你的 subscription ID]/resourceGroups/lmarcus/providers/Microsoft.Network/networkSecurityGroups/createbyconsole-nsg
```

## 不用 az login 就可以使用 terraform 弄 azure 的方式

[terraform 對 service principal 的說明]()

做 service pincipal  
```
$ az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/SUBSCRIPTION_ID"
```
會 output 出來類似這樣的結果  
```
{
  "appId": "00000000-0000-0000-0000-000000000000",
  "displayName": "azure-cli-2017-06-05-10-41-15",
  "name": "http://azure-cli-2017-06-05-10-41-15",
  "password": "0000-0000-0000-0000-000000000000",
  "tenant": "00000000-0000-0000-0000-000000000000"
}
```
請務必把 appId,password,tenant 這三個值記起來