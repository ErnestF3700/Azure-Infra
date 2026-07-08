
resource "azurerm_firewall" "this" {
  name                = local.name
  location            = local.location
  resource_group_name = local.resource_group_name

  sku_name = local.sku_name
  sku_tier = local.sku_tier

  firewall_policy_id = local.firewall_policy_id

  dns_servers = local.dns_servers

  ip_configuration {
    name                 = local.ip_configuration.name
    subnet_id            = local.ip_configuration.subnet_id
    public_ip_address_id = local.ip_configuration.public_ip_address_id
  }

  dynamic "management_ip_configuration" {
    for_each = local.management_ip_configuration == null ? [] : [local.management_ip_configuration]

    content {
      name                 = management_ip_configuration.value.name
      subnet_id            = management_ip_configuration.value.subnet_id
      public_ip_address_id = management_ip_configuration.value.public_ip_address_id
    }
  }

  tags = local.tags
}
