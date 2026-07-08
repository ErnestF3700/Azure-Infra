resource "azurerm_network_security_group" "this" {
  name                = local.name
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags
}
