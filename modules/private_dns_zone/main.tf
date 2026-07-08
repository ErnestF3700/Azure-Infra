resource "azurerm_private_dns_zone" "this" {
  name                = local.name
  resource_group_name = local.resource_group_name

  dynamic "soa_record" {
    for_each = local.soa_record == null ? [] : [local.soa_record]

    content {
      email        = soa_record.value.email
      expire_time  = soa_record.value.expire_time
      minimum_ttl  = soa_record.value.minimum_ttl
      refresh_time = soa_record.value.refresh_time
      retry_time   = soa_record.value.retry_time
      ttl          = soa_record.value.ttl
      tags         = soa_record.value.tags
    }
  }

  tags = local.tags
}
