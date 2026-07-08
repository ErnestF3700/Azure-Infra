resource "azurerm_private_endpoint" "this" {
  name                = local.name
  location            = local.location
  resource_group_name = local.resource_group_name
  subnet_id           = local.subnet_id

  private_service_connection {
    name                           = "${local.name}-psc"
    private_connection_resource_id = local.private_connection_resource_id
    subresource_names              = local.subresource_names
    is_manual_connection           = false
  }

  dynamic "private_dns_zone_group" {
    for_each = local.private_dns_zone_group == null ? [] : [local.private_dns_zone_group]

    content {
      name                 = private_dns_zone_group.value.name
      private_dns_zone_ids = private_dns_zone_group.value.private_dns_zone_ids
    }
  }

  tags = local.tags
}
