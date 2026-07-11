output "id" {
  description = "Resource ID of the Log Analytics Workspace."
  value       = azurerm_log_analytics_workspace.this.id
}

output "name" {
  description = "Name of the Log Analytics Workspace."
  value       = azurerm_log_analytics_workspace.this.name
}

output "location" {
  description = "Azure region of the Log Analytics Workspace."
  value       = azurerm_log_analytics_workspace.this.location
}

output "resource_group_name" {
  description = "Resource Group containing the Log Analytics Workspace."
  value       = azurerm_log_analytics_workspace.this.resource_group_name
}

output "workspace_id" {
  description = "Workspace ID used by Azure Monitor agents."
  value       = azurerm_log_analytics_workspace.this.workspace_id
}

output "primary_shared_key" {
  description = "Primary shared key."
  value       = azurerm_log_analytics_workspace.this.primary_shared_key
  sensitive   = true
}

output "secondary_shared_key" {
  description = "Secondary shared key."
  value       = azurerm_log_analytics_workspace.this.secondary_shared_key
  sensitive   = true
}

output "sku" {
  description = "Workspace SKU."
  value       = azurerm_log_analytics_workspace.this.sku
}

output "retention_in_days" {
  description = "Workspace retention period in days."
  value       = azurerm_log_analytics_workspace.this.retention_in_days
}

output "log_analytics_workspace" {
  description = "Complete Log Analytics Workspace resource."
  value       = azurerm_log_analytics_workspace.this
}
