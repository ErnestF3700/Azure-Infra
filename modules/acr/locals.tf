locals {
  name                = trimspace(var.name)
  resource_group_name = trimspace(var.resource_group_name)
  location            = trimspace(var.location)

  sku = var.sku

  admin_enabled                 = var.admin_enabled
  public_network_access_enabled = var.public_network_access_enabled
  anonymous_pull_enabled        = var.anonymous_pull_enabled
  data_endpoint_enabled         = var.data_endpoint_enabled

  network_rule_bypass_option = var.network_rule_bypass_option
  zone_redundancy_enabled    = var.zone_redundancy_enabled

  identity = var.identity

  tags = {
    for k, v in var.tags :
    trimspace(k) => trimspace(v)
  }
}
