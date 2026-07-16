output "id" {
  description = "Resource ID of the NAT Gateway."
  value       = azurerm_nat_gateway.this.id
}

output "name" {
  description = "Name of the NAT Gateway."
  value       = azurerm_nat_gateway.this.name
}

output "location" {
  description = "Azure region of the NAT Gateway."
  value       = azurerm_nat_gateway.this.location
}

output "resource_group_name" {
  description = "Resource Group containing the NAT Gateway."
  value       = azurerm_nat_gateway.this.resource_group_name
}

output "idle_timeout_in_minutes" {
  description = "Configured idle timeout."
  value       = azurerm_nat_gateway.this.idle_timeout_in_minutes
}

output "resource_guid" {
  description = "Resource GUID of the NAT Gateway."
  value       = azurerm_nat_gateway.this.resource_guid
}

output "nat_gateway" {
  description = "Complete NAT Gateway resource."
  value       = azurerm_nat_gateway.this
}
