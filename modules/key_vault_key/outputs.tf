output "id" {
  description = "Resource ID of the Key Vault Key."
  value       = azurerm_key_vault_key.this.id
}

output "name" {
  description = "Name of the Key Vault Key."
  value       = azurerm_key_vault_key.this.name
}

output "version" {
  description = "Current version of the Key Vault Key."
  value       = azurerm_key_vault_key.this.version
}

output "versionless_id" {
  description = "Versionless Resource ID of the Key Vault Key."
  value       = azurerm_key_vault_key.this.versionless_id
}

output "resource_id" {
  description = "Azure Resource ID of the Key Vault Key."
  value       = azurerm_key_vault_key.this.resource_id
}

output "resource_versionless_id" {
  description = "Versionless Azure Resource ID of the Key Vault Key."
  value       = azurerm_key_vault_key.this.resource_versionless_id
}

output "key_type" {
  description = "Type of the Key Vault Key."
  value       = azurerm_key_vault_key.this.key_type
}

output "key_size" {
  description = "Size of the Key Vault Key in bits."
  value       = azurerm_key_vault_key.this.key_size
}

output "curve" {
  description = "Elliptic Curve associated with the Key Vault Key."
  value       = azurerm_key_vault_key.this.curve
}

output "key_opts" {
  description = "Permitted cryptographic operations."
  value       = azurerm_key_vault_key.this.key_opts
}

output "key" {
  description = "Complete Key Vault Key resource."
  value       = azurerm_key_vault_key.this
}
output "not_before_date" {
  description = "Activation date of the Key Vault Key."
  value       = azurerm_key_vault_key.this.not_before_date
}
output "expiration_date" {
  description = "Expiration date of the Key Vault Key."
  value       = azurerm_key_vault_key.this.expiration_date
}
