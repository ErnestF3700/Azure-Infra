output "id" {
  description = "Resource ID."
  value       = azurerm_firewall_policy_rule_collection_group.this.id
}

output "name" {
  description = "Rule Collection Group name."
  value       = azurerm_firewall_policy_rule_collection_group.this.name
}

output "rule_collection_group" {
  description = "Complete Firewall Rule Collection Group."
  value       = azurerm_firewall_policy_rule_collection_group.this
}
