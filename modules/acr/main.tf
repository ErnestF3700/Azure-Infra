resource "azurerm_container_registry" "this" {
  name                = local.name
  resource_group_name = local.resource_group_name
  location            = local.location

  sku = local.sku

  admin_enabled                 = local.admin_enabled
  public_network_access_enabled = local.public_network_access_enabled
  anonymous_pull_enabled        = local.anonymous_pull_enabled
  data_endpoint_enabled         = local.data_endpoint_enabled

  network_rule_bypass_option = local.network_rule_bypass_option

  zone_redundancy_enabled = (
    local.sku == "Premium"
    ? local.zone_redundancy_enabled
    : false
  )

  dynamic "identity" {
    for_each = local.identity == null ? [] : [local.identity]

    content {
      type         = identity.value.type
      identity_ids = try(identity.value.identity_ids, null)
    }
  }

  tags = local.tags
}
