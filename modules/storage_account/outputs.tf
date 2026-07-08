output "id" {
  description = "Resource ID of the Storage Account."
  value       = azurerm_storage_account.this.id
}

output "name" {
  description = "Name of the Storage Account."
  value       = azurerm_storage_account.this.name
}

output "location" {
  description = "Azure region of the Storage Account."
  value       = azurerm_storage_account.this.location
}

output "resource_group_name" {
  description = "Resource Group containing the Storage Account."
  value       = azurerm_storage_account.this.resource_group_name
}

output "primary_blob_endpoint" {
  description = "Primary Blob endpoint."
  value       = azurerm_storage_account.this.primary_blob_endpoint
}

output "primary_file_endpoint" {
  description = "Primary File endpoint."
  value       = azurerm_storage_account.this.primary_file_endpoint
}

output "primary_queue_endpoint" {
  description = "Primary Queue endpoint."
  value       = azurerm_storage_account.this.primary_queue_endpoint
}

output "primary_table_endpoint" {
  description = "Primary Table endpoint."
  value       = azurerm_storage_account.this.primary_table_endpoint
}

output "primary_web_endpoint" {
  description = "Primary Static Website endpoint."
  value       = azurerm_storage_account.this.primary_web_endpoint
}

output "primary_blob_host" {
  description = "Primary Blob host."
  value       = azurerm_storage_account.this.primary_blob_host
}

output "primary_file_host" {
  description = "Primary File host."
  value       = azurerm_storage_account.this.primary_file_host
}

output "primary_queue_host" {
  description = "Primary Queue host."
  value       = azurerm_storage_account.this.primary_queue_host
}

output "primary_table_host" {
  description = "Primary Table host."
  value       = azurerm_storage_account.this.primary_table_host
}

output "primary_access_key" {
  description = "Primary access key."
  value       = azurerm_storage_account.this.primary_access_key
  sensitive   = true
}

output "secondary_access_key" {
  description = "Secondary access key."
  value       = azurerm_storage_account.this.secondary_access_key
  sensitive   = true
}

output "storage_account" {
  description = "Complete Storage Account resource."
  value       = azurerm_storage_account.this
}
