output "id" {
  description = "Resource ID of the Role Assignment."
  value       = azurerm_role_assignment.this.id
}

output "name" {
  description = "Role Assignment name."
  value       = azurerm_role_assignment.this.name
}

output "scope" {
  description = "Assignment scope."
  value       = azurerm_role_assignment.this.scope
}

output "principal_id" {
  description = "Principal Object ID."
  value       = azurerm_role_assignment.this.principal_id
}

output "role_definition_id" {
  description = "Role Definition ID."
  value       = azurerm_role_assignment.this.role_definition_id
}

output "role_assignment" {
  description = "Complete Role Assignment resource."
  value       = azurerm_role_assignment.this
}
