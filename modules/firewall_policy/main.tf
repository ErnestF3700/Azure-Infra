resource "azurerm_firewall_policy" "this" {
  name                = local.name
  resource_group_name = local.resource_group_name
  location            = local.location

  sku = local.sku

  threat_intelligence_mode = local.threat_intelligence_mode

  dynamic "dns" {
    for_each = local.dns == null ? [] : [local.dns]

    content {
      proxy_enabled = dns.value.proxy_enabled
      servers       = dns.value.servers
    }
  }

  tags = local.tags
}
