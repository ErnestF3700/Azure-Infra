resource "azurerm_storage_account" "this" {
  name                = local.name
  resource_group_name = local.resource_group_name
  location            = local.location

  account_kind             = local.account_kind
  account_tier             = local.account_tier
  account_replication_type = local.account_replication_type
  access_tier              = local.access_tier

  min_tls_version                 = local.min_tls_version
  https_traffic_only_enabled      = local.https_traffic_only_enabled
  public_network_access_enabled   = local.public_network_access_enabled
  shared_access_key_enabled       = local.shared_access_key_enabled
  allow_nested_items_to_be_public = local.allow_nested_items_to_be_public

  is_hns_enabled           = local.is_hns_enabled
  nfsv3_enabled            = local.nfsv3_enabled
  sftp_enabled             = local.sftp_enabled
  large_file_share_enabled = local.large_file_share_enabled

  dynamic "identity" {
    for_each = local.identity == null ? [] : [local.identity]

    content {
      type         = identity.value.type
      identity_ids = try(identity.value.identity_ids, null)
    }
  }

  blob_properties {

    versioning_enabled = local.blob_versioning_enabled

    delete_retention_policy {
      days = local.delete_retention_days
    }

    container_delete_retention_policy {
      days = local.container_delete_retention_days
    }
  }

  network_rules {

    default_action = local.network_rules.default_action

    bypass = local.network_rules.bypass

    ip_rules = local.network_rules.ip_rules

    virtual_network_subnet_ids = local.network_rules.virtual_network_subnet_ids
  }

  tags = local.tags
}
