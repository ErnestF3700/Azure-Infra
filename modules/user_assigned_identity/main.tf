resource "azurerm_user_assigned_identity" "this" {
  name                = local.name
  resource_group_name = local.resource_group_name
  location            = local.location

  tags = local.tags
}
