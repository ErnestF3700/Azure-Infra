# Azure Storage Account Terraform Module

Production-ready Terraform module for Azure Storage Accounts.

## Features

- StorageV2
- Standard / Premium
- LRS / ZRS / GRS / GZRS / RAGRS / RAGZRS
- Blob Versioning
- Blob Soft Delete
- Container Soft Delete
- Network Rules
- Managed Identity
- HTTPS Only
- TLS Configuration
- Hierarchical Namespace (ADLS Gen2)
- SFTP
- NFSv3
- Large File Shares
- Enterprise Tagging
- Rich Outputs
- Terraform >= 1.11
- AzureRM ~> 4.0

## Example

```terraform
module "storage" {
  source = "./modules/storage"

  name                = "stplatform001"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location

  tags = {
    Environment = "dev"
    Project     = "platform"
  }
}
```

## Outputs

- id
- name
- location
- resource_group_name
- primary_blob_endpoint
- primary_file_endpoint
- primary_queue_endpoint
- primary_table_endpoint
- primary_web_endpoint
- storage_account
