locals {
  name                = trimspace(var.name)
  resource_group_name = trimspace(var.resource_group_name)
  location            = trimspace(var.location)

  account_kind             = var.account_kind
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  access_tier              = var.access_tier

  min_tls_version                 = var.min_tls_version
  https_traffic_only_enabled      = var.https_traffic_only_enabled
  public_network_access_enabled   = var.public_network_access_enabled
  shared_access_key_enabled       = var.shared_access_key_enabled
  allow_nested_items_to_be_public = var.allow_nested_items_to_be_public

  is_hns_enabled           = var.is_hns_enabled
  nfsv3_enabled            = var.nfsv3_enabled
  sftp_enabled             = var.sftp_enabled
  large_file_share_enabled = var.large_file_share_enabled

  blob_versioning_enabled         = var.blob_versioning_enabled
  delete_retention_days           = var.delete_retention_days
  container_delete_retention_days = var.container_delete_retention_days

  identity      = var.identity
  network_rules = var.network_rules

  tags = {
    for k, v in var.tags :
    trimspace(k) => trimspace(v)
  }
}
