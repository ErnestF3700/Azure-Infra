output "resource_group_name" {
  description = "Bootstrap Resource Group."
  value       = azurerm_resource_group.bootstrap.name
}

output "storage_account_name" {
  description = "Terraform Storage Account."
  value       = azurerm_storage_account.tfstate.name
}

output "container_name" {
  description = "Terraform state container."
  value       = azurerm_storage_container.tfstate.name
}
