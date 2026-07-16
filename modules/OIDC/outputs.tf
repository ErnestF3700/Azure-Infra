output "id" {
  description = "Resource ID of the Federated Identity Credential."
  value       = azurerm_federated_identity_credential.this.id
}

output "name" {
  description = "Name of the Federated Identity Credential."
  value       = azurerm_federated_identity_credential.this.name
}

output "issuer" {
  description = "OIDC issuer."
  value       = azurerm_federated_identity_credential.this.issuer
}

output "subject" {
  description = "OIDC subject."
  value       = azurerm_federated_identity_credential.this.subject
}

output "audience" {
  description = "OIDC audiences."
  value       = azurerm_federated_identity_credential.this.audience
}

output "credential" {
  description = "Complete Federated Identity Credential resource."
  value       = azurerm_federated_identity_credential.this
}
