# Azure Role Assignment Terraform Module

Production-ready Terraform module for Azure Role Assignments.

## Features

- Azure Role Assignment
- Built-in role support
- Custom role support
- RBAC Conditions
- Service Principal support
- User support
- Group support
- Managed Identity support
- Rich outputs
- Terraform >=1.11
- AzureRM ~>4.0

## Example

```terraform
module "storage_blob_contributor" {
  source = "./modules/role_assignment"

  scope = module.storage.id

  role_definition_name = "Storage Blob Data Contributor"

  principal_id = module.user_assigned_identity.principal_id
}
```
