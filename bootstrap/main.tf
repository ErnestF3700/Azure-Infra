resource "random_string" "suffix" {

  length  = 6
  upper   = false
  special = false

}

resource "azurerm_resource_group" "bootstrap" {

  name     = var.resource_group_name
  location = var.location

  tags = local.common_tags

}

resource "azurerm_storage_account" "tfstate" {

  name = lower("${var.storage_account_prefix}${random_string.suffix.result}")

  resource_group_name = azurerm_resource_group.bootstrap.name
  location            = azurerm_resource_group.bootstrap.location

  account_tier             = "Standard"
  account_replication_type = "ZRS"

  min_tls_version = "TLS1_2"

  https_traffic_only_enabled = true

  shared_access_key_enabled = true

  allow_nested_items_to_be_public = false

  infrastructure_encryption_enabled = true

  tags = local.common_tags

}

resource "azurerm_storage_container" "tfstate" {

  name = var.container_name

  storage_account_id = azurerm_storage_account.tfstate.id

  container_access_type = "private"

}
