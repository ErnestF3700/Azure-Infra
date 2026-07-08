resource "azurerm_virtual_network" "this" {
  name                = local.name
  resource_group_name = local.resource_group_name
  location            = local.location
  address_space       = local.address_space
  dns_servers         = local.dns_servers
  tags                = local.tags

  dynamic "ddos_protection_plan" {
    for_each = local.ddos_protection_plan == null ? [] : [local.ddos_protection_plan]

    content {
      id     = ddos_protection_plan.value.id
      enable = ddos_protection_plan.value.enable
    }
  }
}
