# Azure Key Vault Secret Terraform Module

Production-ready Terraform module for Azure Key Vault Secrets.

## Features

- Azure Key Vault Secret
- Secret Value
- Content Type
- Activation Date
- Expiration Date
- Enterprise Tagging
- Rich Outputs
- Terraform >= 1.11
- AzureRM ~> 4.0

## Example

```terraform
module "secret" {
  source = "./modules/key_vault_secret"

  name         = "sql-admin-password"
  key_vault_id = module.keyvault.id
  value         = var.sql_admin_password
}
```

## Outputs

- id
- name
- version
- versionless_id
- resource_id
- resource_versionless_id
- secret
