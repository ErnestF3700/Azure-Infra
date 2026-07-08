variable "name" {
  description = "Name of the subnet. The name must follow the Azure CAF convention and start with 'snet-'."
  type        = string

  validation {
    condition     = length(trimspace(var.name)) >= 6 && length(trimspace(var.name)) <= 80
    error_message = "The subnet name must contain between 6 and 80 characters."
  }

  validation {
    condition     = can(regex("^snet-[a-z0-9]([a-z0-9-]*[a-z0-9])?$", trimspace(var.name)))
    error_message = "The subnet name must start with 'snet-', use only lowercase letters, numbers, and hyphens, and must not end with a hyphen."
  }
}

variable "virtual_network_name" {
  description = "Name of the existing virtual network containing the subnet. The name must follow the Azure CAF convention and start with 'vnet-'."
  type        = string

  validation {
    condition     = length(trimspace(var.virtual_network_name)) >= 6 && length(trimspace(var.virtual_network_name)) <= 64
    error_message = "The virtual network name must contain between 6 and 64 characters."
  }

  validation {
    condition     = can(regex("^vnet-[a-z0-9]([a-z0-9-]*[a-z0-9])?$", trimspace(var.virtual_network_name)))
    error_message = "The virtual network name must start with 'vnet-', use only lowercase letters, numbers, and hyphens, and must not end with a hyphen."
  }
}

variable "resource_group_name" {
  description = "Name of the existing resource group containing the virtual network. The name must follow the Azure CAF convention and start with 'rg-'."
  type        = string

  validation {
    condition     = length(trimspace(var.resource_group_name)) >= 4 && length(trimspace(var.resource_group_name)) <= 90
    error_message = "The resource group name must contain between 4 and 90 characters."
  }

  validation {
    condition     = can(regex("^rg-[a-z0-9]([a-z0-9-]*[a-z0-9])?$", trimspace(var.resource_group_name)))
    error_message = "The resource group name must start with 'rg-', use only lowercase letters, numbers, and hyphens, and must not end with a hyphen."
  }
}

variable "address_prefixes" {
  description = "One or more IPv4 or IPv6 CIDR prefixes assigned to the subnet. Prefixes must belong to the parent virtual network address space."
  type        = list(string)

  validation {
    condition     = length(var.address_prefixes) > 0
    error_message = "At least one subnet address prefix must be specified."
  }

  validation {
    condition     = alltrue([for cidr in var.address_prefixes : can(cidrhost(trimspace(cidr), 0))])
    error_message = "Every address prefix must be a valid IPv4 or IPv6 CIDR prefix."
  }

  validation {
    condition     = length(distinct([for cidr in var.address_prefixes : trimspace(cidr)])) == length(var.address_prefixes)
    error_message = "Subnet address prefixes must be unique."
  }
}

variable "service_endpoints" {
  description = "Optional Azure service endpoints enabled on the subnet."
  type        = set(string)
  default     = []

  validation {
    condition = alltrue([
      for endpoint in var.service_endpoints : contains([
        "Microsoft.AzureActiveDirectory",
        "Microsoft.AzureCosmosDB",
        "Microsoft.ContainerRegistry",
        "Microsoft.EventHub",
        "Microsoft.KeyVault",
        "Microsoft.ServiceBus",
        "Microsoft.Sql",
        "Microsoft.Storage",
        "Microsoft.Storage.Global",
        "Microsoft.Web"
      ], endpoint)
    ])
    error_message = "Each service endpoint must be a service supported by AzureRM for Azure subnets."
  }
}

variable "service_endpoint_policy_ids" {
  description = "Optional resource IDs of Service Endpoint Policies to associate with the subnet."
  type        = set(string)
  default     = []

  validation {
    condition = alltrue([
      for id in var.service_endpoint_policy_ids : can(regex(
        "^/subscriptions/[0-9a-fA-F-]{36}/resourceGroups/[^/]+/providers/Microsoft\\.Network/serviceEndpointPolicies/[^/]+$",
        trimspace(id)
      ))
    ])
    error_message = "Each Service Endpoint Policy ID must be a valid Azure resource ID for Microsoft.Network/serviceEndpointPolicies."
  }
}

variable "delegations" {
  description = "Optional subnet delegations keyed by a stable delegation name. Actions must be valid for the delegated Azure service."
  type = map(object({
    service_delegation = object({
      name    = string
      actions = optional(set(string), [])
    })
  }))
  default = {}

  validation {
    condition = alltrue([
      for name, delegation in var.delegations :
      length(trimspace(name)) >= 1 && length(trimspace(name)) <= 80 &&
      can(regex("^[A-Za-z0-9][A-Za-z0-9._-]*[A-Za-z0-9_]$|^[A-Za-z0-9]$", trimspace(name)))
    ])
    error_message = "Delegation keys must contain 1-80 valid Azure name characters and start and end with an alphanumeric character or underscore."
  }

  validation {
    condition = alltrue([
      for delegation in values(var.delegations) :
      can(regex("^[A-Za-z0-9.]+/[A-Za-z0-9.]+$", trimspace(delegation.service_delegation.name)))
    ])
    error_message = "Each delegated service name must use the '<resource-provider>/<resource-type>' format."
  }

  validation {
    condition = alltrue(flatten([
      for delegation in values(var.delegations) : [
        for action in delegation.service_delegation.actions :
        length(trimspace(action)) > 0 && can(regex("^[A-Za-z0-9.]+(/[A-Za-z0-9.*_-]+)+$", trimspace(action)))
      ]
    ]))
    error_message = "Delegation actions must be non-empty Azure resource provider action paths."
  }
}

variable "private_endpoint_network_policies" {
  description = "Network policy mode for private endpoints in the subnet."
  type        = string
  default     = "Disabled"

  validation {
    condition = contains([
      "Disabled",
      "Enabled",
      "NetworkSecurityGroupEnabled",
      "RouteTableEnabled"
    ], var.private_endpoint_network_policies)
    error_message = "Private endpoint network policies must be 'Disabled', 'Enabled', 'NetworkSecurityGroupEnabled', or 'RouteTableEnabled'."
  }
}

variable "private_link_service_network_policies_enabled" {
  description = "Whether network policies are enabled for Private Link services in the subnet."
  type        = bool
  default     = true
}
