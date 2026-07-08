# Azure Bastion Host module

Creates one Azure Bastion Host using an existing `AzureBastionSubnet` and Public
IP address. The module does not create the Public IP, virtual network, subnet,
network security group, or route table.

## Requirements

| Name | Version |
|------|---------|
| Terraform | >= 1.11.0 |
| AzureRM | ~> 4.0 |

The calling configuration must configure the AzureRM provider. This reusable
module does not contain a provider block or backend configuration.

## Naming

Supply the complete Bastion name through `name`. CAF guidance uses the `bas-`
abbreviation, for example `bas-hub-prod-weu-001`. The module validates Azure
naming constraints without imposing an organization-specific structure.

## Usage

```hcl
module "hub_bastion" {
  source = "./modules/bastion"

  name                = "bas-hub-prod-weu-001"
  resource_group_name = "rg-connectivity-prod-weu-001"
  location            = "westeurope"
  subnet_id           = module.azure_bastion_subnet.id
  public_ip_id         = module.bastion_public_ip.id
  sku                  = "Premium"
  scale_units          = 2

  copy_paste_enabled        = true
  file_copy_enabled         = false
  ip_connect_enabled        = true
  kerberos_enabled          = true
  shareable_link_enabled    = false
  tunneling_enabled         = true
  session_recording_enabled = true

  tags = {
    environment = "production"
    managed_by  = "terraform"
    workload    = "connectivity"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of the Azure Bastion Host. | `string` | n/a | yes |
| resource_group_name | Resource group containing the Bastion Host. | `string` | n/a | yes |
| location | Azure region for the Bastion Host. | `string` | n/a | yes |
| subnet_id | Resource ID of the existing `AzureBastionSubnet`. | `string` | n/a | yes |
| public_ip_id | Resource ID of the existing Public IP address. | `string` | n/a | yes |
| ip_configuration_name | Name of the Bastion IP configuration. | `string` | `"bastion-ip-configuration"` | no |
| sku | Bastion SKU: `Basic`, `Standard`, or `Premium`. | `string` | `"Basic"` | no |
| scale_units | Number of scale units from 2 through 50. | `number` | `2` | no |
| copy_paste_enabled | Enable copy and paste. | `bool` | `true` | no |
| file_copy_enabled | Enable file copy. | `bool` | `false` | no |
| ip_connect_enabled | Enable IP-based connections. | `bool` | `false` | no |
| kerberos_enabled | Enable Kerberos authentication. | `bool` | `false` | no |
| shareable_link_enabled | Enable shareable links. | `bool` | `false` | no |
| tunneling_enabled | Enable native client tunneling. | `bool` | `false` | no |
| session_recording_enabled | Enable Premium session recording. | `bool` | `false` | no |
| tags | Tags assigned to the Bastion Host. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Resource ID of the Bastion Host. |
| name | Name of the Bastion Host. |
| location | Azure region containing the Bastion Host. |
| resource_group_name | Resource group containing the Bastion Host. |
| dns_name | Fully qualified domain name of the Bastion Host. |
| bastion_host | Complete Azure Bastion Host resource object. |

## SKU and security guidance

- Basic supports two scale units. Standard and Premium support between 2 and 50.
- File copy, IP Connect, Kerberos, shareable links, and tunneling require Standard
  or Premium. Session recording requires Premium.
- Optional data-transfer features default to disabled. Enable only the features
  required by the operational access model.
- The supplied Public IP should use the Standard SKU and static allocation.
- The `AzureBastionSubnet` should use `/26` or larger and must follow the current
  Azure Bastion network security group requirements.
- Apply subnet policy, NSG, route, diagnostic settings, and access controls in
  dedicated modules so their lifecycles and permissions remain independently
  governed.
