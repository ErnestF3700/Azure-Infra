resource "azurerm_subnet" "this" {
  name                                          = local.name
  resource_group_name                           = local.resource_group_name
  virtual_network_name                          = local.virtual_network_name
  address_prefixes                              = local.address_prefixes
  service_endpoints                             = local.service_endpoints
  service_endpoint_policy_ids                   = local.service_endpoint_policy_ids
  private_endpoint_network_policies             = var.private_endpoint_network_policies
  private_link_service_network_policies_enabled = var.private_link_service_network_policies_enabled

  dynamic "delegation" {
    for_each = local.delegations

    content {
      name = delegation.key

      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = delegation.value.service_delegation.actions
      }
    }
  }
}
