output "id" {
  description = "Resource ID of the User Assigned Managed Identity."
  value       = azurerm_user_assigned_identity.this.id
}

output "name" {
  description = "Name of the User Assigned Managed Identity."
  value       = azurerm_user_assigned_identity.this.name
}

output "client_id" {
  description = "Client ID of the managed identity."
  value       = azurerm_user_assigned_identity.this.client_id
}

output "principal_id" {
  description = "Principal ID of the managed identity."
  value       = azurerm_user_assigned_identity.this.principal_id
}

output "tenant_id" {
  description = "Tenant ID of the managed identity."
  value       = azurerm_user_assigned_identity.this.tenant_id
}

output "resource_group_name" {
  description = "Resource Group containing the managed identity."
  value       = azurerm_user_assigned_identity.this.resource_group_name
}

output "location" {
  description = "Azure region of the managed identity."
  value       = azurerm_user_assigned_identity.this.location
}

output "user_assigned_identity" {
  description = "Complete User Assigned Managed Identity resource."
  value       = azurerm_user_assigned_identity.this
}
