# Azure Key Vault Terraform Module

Production-ready Terraform module for Azure Key Vault.

## Features

- Azure Key Vault
- Standard and Premium SKU
- Azure RBAC authorization
- Soft Delete
- Purge Protection
- Network ACLs
- Public Network Access configuration
- Enterprise tagging
- Rich outputs
- Terraform >= 1.11
- AzureRM ~> 4.0

## Example

```terraform
module "keyvault" {
  source = "./modules/keyvault"

  name                = "kv-platform-dev-weu"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location

  tenant_id = data.azurerm_client_config.current.tenant_id

  tags = {
    Environment = "dev"
    Platform    = "azure"
  }
}
```

## Outputs

- id
- name
- location
- resource_group_name
- vault_uri
- tenant_id
- sku_name
- soft_delete_retention_days
- keyvault
