provider "azurerm" {
  version = "~> 1.41"
  alias = "one"
  subscription_id = var.subscription_one_id
}

provider "azurerm" {
  version = "~> 1.41"
  alias = "two"
  subscription_id = var.subscription_two_id
}

data "azurerm_resource_group" "one" {
  provider = azurerm.one
  name     = var.subscription_one_rg
}

data "azurerm_resource_group" "two" {
  provider = azurerm.two
  name     = var.subscription_two_rg
}

data "azurerm_virtual_network" "onevnet" {
provider                       = azurerm.one
name                           = var.subscription_one_vnet
resource_group_name            = data.azurerm_resource_group.one.name
}

data "azurerm_virtual_network" "twovnet" {
  provider                     = azurerm.two
  name                         = var.subscription_two_vnet
  resource_group_name          = data.azurerm_resource_group.two.name
}

resource "azurerm_virtual_network_peering" "vnet_peer_1" {
  provider                     = azurerm.one
  name                         = var.peer_one_to_two
  resource_group_name          = data.azurerm_resource_group.one.name
  virtual_network_name         = data.azurerm_virtual_network.onevnet.name
  remote_virtual_network_id    = data.azurerm_virtual_network.twovnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false
}

resource "azurerm_virtual_network_peering" "vnet_peer_2" {
  provider                     = azurerm.two
  name                         = var.peer_two_to_one
  resource_group_name          = data.azurerm_resource_group.two.name
  virtual_network_name         = data.azurerm_virtual_network.twovnet.name
  remote_virtual_network_id    = data.azurerm_virtual_network.onevnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false
}


