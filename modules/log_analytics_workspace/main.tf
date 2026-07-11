resource "azurerm_log_analytics_workspace" "this" {
  name                = local.name
  resource_group_name = local.resource_group_name
  location            = local.location

  sku = local.sku

  retention_in_days = local.retention_in_days
  daily_quota_gb    = local.daily_quota_gb

  internet_ingestion_enabled = local.internet_ingestion_enabled
  internet_query_enabled     = local.internet_query_enabled

  local_authentication_disabled = local.local_authentication_disabled

  reservation_capacity_in_gb_per_day = local.reservation_capacity_in_gb_per_day

  tags = local.tags
}
