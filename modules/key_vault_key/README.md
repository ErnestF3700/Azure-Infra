# Azure Key Vault Key Terraform Module

Production-ready Terraform module for Azure Key Vault Keys.

## Features

- Azure Key Vault Key
- RSA Keys
- RSA-HSM Keys
- EC Keys
- EC-HSM Keys
- Key Rotation Policy
- Key Expiration
- Key Activation
- Configurable Key Operations
- Enterprise tagging
- Rich outputs
- Terraform >= 1.11
- AzureRM ~> 4.0

## Example

```terraform
module "key_vault_key" {
  source = "./modules/key_vault_key"

  name         = "cmk-storage"
  key_vault_id = module.keyvault.id

  key_type = "RSA"
  key_size = 4096

  tags = {
    Environment = "dev"
    Platform    = "azure"
  }
}
```

## Outputs

- id
- name
- version
- versionless_id
- resource_id
- resource_versionless_id
- key_type
- key_size
- curve
- key_opts
- key
