output "id" {
  description = "Resource ID of the Key Vault."
  value       = azurerm_key_vault.this.id
}

output "name" {
  description = "Name of the Key Vault."
  value       = azurerm_key_vault.this.name
}

output "location" {
  description = "Azure region of the Key Vault."
  value       = azurerm_key_vault.this.location
}

output "resource_group_name" {
  description = "Resource Group containing the Key Vault."
  value       = azurerm_key_vault.this.resource_group_name
}

output "vault_uri" {
  description = "DNS URI of the Key Vault."
  value       = azurerm_key_vault.this.vault_uri
}

output "tenant_id" {
  description = "Microsoft Entra tenant ID associated with the Key Vault."
  value       = azurerm_key_vault.this.tenant_id
}

output "sku_name" {
  description = "SKU of the Key Vault."
  value       = azurerm_key_vault.this.sku_name
}

output "soft_delete_retention_days" {
  description = "Soft delete retention period."
  value       = azurerm_key_vault.this.soft_delete_retention_days
}

output "keyvault" {
  description = "Complete Key Vault resource."
  value       = azurerm_key_vault.this
}
output "enable_rbac_authorization" {
  description = "Whether Azure RBAC authorization is enabled."
  value       = azurerm_key_vault.this.enable_rbac_authorization
}
