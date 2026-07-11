# Azure Log Analytics Workspace Terraform Module

# Production-ready Terraform module for Azure Log Analytics Workspace.

## Features

# - Azure Log Analytics Workspace
# - Configurable SKU
# - Configurable data retention
# - Daily ingestion quota
# - Internet ingestion endpoint configuration
# - Internet query endpoint configuration
# - Local authentication configuration
# - Capacity reservation support
# - Enterprise tagging
# - Rich outputs
# - Terraform >= 1.11
# - AzureRM ~> 4.0

## Example

# ```terraform
# module "log_analytics_workspace" {
#   source = "./modules/log_analytics_workspace"

#   name                = "law-platform-dev-weu"
#   resource_group_name = module.resource_group.name
#   location            = module.resource_group.location

#   sku               = "PerGB2018"
#   retention_in_days = 30

#   tags = {
#     Environment = "dev"
#     Platform    = "azure"
#   }
# }
# ```

## Outputs

# - id
# - name
# - location
# - resource_group_name
# - workspace_id
# - primary_shared_key
# - secondary_shared_key
# - sku
# - retention_in_days
# - log_analytics_workspace
