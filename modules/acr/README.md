# Azure Container Registry Terraform Module

Production-ready Terraform module for Azure Container Registry.

## Features

- Azure Container Registry
- Basic / Standard / Premium SKU
- Managed Identity
- Admin Account
- Anonymous Pull
- Public Network Access
- Dedicated Data Endpoint
- Zone Redundancy
- Enterprise Tagging
- Rich Outputs
- Terraform >= 1.11
- AzureRM ~> 4.0

## Example

```terraform
module "acr" {
  source = "./modules/acr"

  name                = "acrplatformdev001"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location

  sku = "Premium"

  tags = {
    Environment = "dev"
    Platform    = "azure"
  }
}
```
