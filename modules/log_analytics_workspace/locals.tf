locals {
  name                = trimspace(var.name)
  resource_group_name = trimspace(var.resource_group_name)
  location            = trimspace(var.location)

  sku = var.sku

  retention_in_days = var.retention_in_days
  daily_quota_gb    = var.daily_quota_gb

  internet_ingestion_enabled = var.internet_ingestion_enabled
  internet_query_enabled     = var.internet_query_enabled

  local_authentication_disabled = var.local_authentication_disabled

  reservation_capacity_in_gb_per_day = var.reservation_capacity_in_gb_per_day

  tags = {
    for k, v in var.tags :
    trimspace(k) => trimspace(v)
  }
}
