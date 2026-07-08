output "id" {
  description = "Resource ID of the Key Vault Secret."
  value       = azurerm_key_vault_secret.this.id
}

output "name" {
  description = "Name of the Key Vault Secret."
  value       = azurerm_key_vault_secret.this.name
}

output "version" {
  description = "Current Secret version."
  value       = azurerm_key_vault_secret.this.version
}

output "versionless_id" {
  description = "Versionless Secret ID."
  value       = azurerm_key_vault_secret.this.versionless_id
}

output "resource_id" {
  description = "Azure Resource ID."
  value       = azurerm_key_vault_secret.this.resource_id
}

output "resource_versionless_id" {
  description = "Versionless Azure Resource ID."
  value       = azurerm_key_vault_secret.this.resource_versionless_id
}

output "secret" {
  description = "Complete Key Vault Secret resource."
  value       = azurerm_key_vault_secret.this
}
output "content_type" {
  description = "Content type of the secret."
  value       = azurerm_key_vault_secret.this.content_type
}

output "value" {
  description = "Secret value."
  value       = azurerm_key_vault_secret.this.value
  sensitive   = true
}
