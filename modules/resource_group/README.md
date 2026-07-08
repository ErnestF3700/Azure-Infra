# Azure Resource Group Terraform module

Creates an Azure resource group and, optionally, a management lock scoped to the resource group.

The caller must configure the AzureRM provider and Terraform backend. Resource group names are required to follow the Azure Cloud Adoption Framework convention `rg-<workload>-<environment>-<region>` and use lowercase letters, numbers, and hyphens.

## Usage

```hcl
module "resource_group" {
  source = "../../modules/resource_group"

  name     = "rg-payments-prod-weu"
  location = "westeurope"

  tags = {
    environment = "production"
    workload    = "payments"
    owner       = "platform-team"
    cost_center = "cc-1234"
    managed_by  = "terraform"
  }

  management_lock_enabled = true
  management_lock_level   = "CanNotDelete"
}
```

## Requirements

| Name | Version |
|------|---------|
| Terraform | >= 1.11.0 |
| AzureRM | ~> 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `name` | CAF-compliant resource group name beginning with `rg-`. | `string` | n/a | yes |
| `location` | Canonical Azure region name, such as `westeurope`. | `string` | n/a | yes |
| `tags` | Enterprise tags applied to the resource group. | `map(string)` | `{}` | no |
| `management_lock_enabled` | Whether to create a resource group management lock. | `bool` | `false` | no |
| `management_lock_name` | Lock name; when null, `lock-<resource-group-name>` is used. | `string` | `null` | no |
| `management_lock_level` | Lock level: `CanNotDelete` or `ReadOnly`. | `string` | `"CanNotDelete"` | no |
| `management_lock_notes` | Notes describing the reason for the lock. | `string` | `"Managed by Terraform."` | no |

## Outputs

| Name | Description |
|------|-------------|
| `id` | Resource ID of the resource group. |
| `name` | Name of the resource group. |
| `location` | Azure region of the resource group. |

## Management lock behavior

The lock is created only when `management_lock_enabled` is `true`. A `ReadOnly` lock prevents control-plane write operations in the resource group; verify that this behavior is suitable for resources managed by Terraform before enabling it.
