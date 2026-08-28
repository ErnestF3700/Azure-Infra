module "resource_group" {
  source = "../../modules/resource_group"

  name     = var.resource_group_name
  location = var.location

  tags = var.tags

  management_lock_enabled = false
}


module "hub_vnet" {
  source = "../../modules/vnet"

  name                = "vnet-hub-${var.environment}-weu"
  resource_group_name = module.resource_group.name
  location            = var.location

  address_space = var.hub_address_space

  tags = var.tags
}


module "spoke_vnet" {
  source = "../../modules/vnet"

  name                = "vnet-app-${var.environment}-weu"
  resource_group_name = module.resource_group.name
  location            = var.location

  address_space = var.spoke_address_space

  tags = var.tags
}


module "hub_to_spoke" {
  source = "../../modules/vnet_peering"

  name                      = "peer-hub-to-app-${var.environment}-weu"
  resource_group_name       = module.resource_group.name
  virtual_network_name      = module.hub_vnet.name
  remote_virtual_network_id = module.spoke_vnet.id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
  use_remote_gateways          = false
}


module "spoke_to_hub" {
  source = "../../modules/vnet_peering"

  name                      = "peer-app-to-hub-${var.environment}-weu"
  resource_group_name       = module.resource_group.name
  virtual_network_name      = module.spoke_vnet.name
  remote_virtual_network_id = module.hub_vnet.id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = true
}
