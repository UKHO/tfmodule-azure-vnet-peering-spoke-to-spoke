# tfmodule-azure-vnet-perring-spoke-to-spoke

really rough how to use.

these are the variables needed on the module, the value can be how ever you like the module uses aliases generated in the root module, you will get a warning with v2 saying something like the way to link providers has changed but it will still work.

```terraform
module "nsgflowlogs" {
  source                        = "github.com/UKHO/tfmodule-azure-vnet-peering-spoke-to-spoke?ref=0.2.0"
  providers = {
    azurerm.one = azurerm.aliasforsubone
    azurerm.two = azurerm.aliasforsubtwo
  }
   
   subscription_one_rg      = "subonerg"
   subscription_two_rg      = "subtworg"
   subscription_one_vnet    = "subonvnetname"
   subscription_two_vnet    = "subtwovnetname"
   peer_one_to_two          = "nameforpeeringononetotwo"
   peer_two_to_one          = "nameforpeeringontwotoone"
 }
```
