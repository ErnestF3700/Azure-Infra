# Azure User Assigned Managed Identity Terraform Module

Production-ready Terraform module for Azure User Assigned Managed Identities.

## Features

- Azure User Assigned Managed Identity
- Enterprise tagging
- Input validation
- Rich outputs
- Terraform >= 1.11
- AzureRM ~> 4.0

## Example

```terraform
module "identity" {
  source = "./modules/user_assigned_identity"

  name                = "id-platform-dev-weu"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location

  tags = {
    Environment = "dev"
    Platform    = "azure"
  }
}
```

## Outputs

- id
- name
- client_id
- principal_id
- tenant_id
- resource_group_name
- location
- user_assigned_identity
