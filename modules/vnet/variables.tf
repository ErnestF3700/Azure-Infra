variable "name" {
  description = "Name of the virtual network. The name must follow the Azure CAF convention and start with 'vnet-'."
  type        = string

  validation {
    condition     = length(trimspace(var.name)) >= 6 && length(trimspace(var.name)) <= 64
    error_message = "The virtual network name must contain between 6 and 64 characters."
  }

  validation {
    condition     = can(regex("^vnet-[a-z0-9]([a-z0-9-]*[a-z0-9])?$", trimspace(var.name)))
    error_message = "The virtual network name must start with 'vnet-', use only lowercase letters, numbers, and hyphens, and must not end with a hyphen."
  }
}

variable "resource_group_name" {
  description = "Name of the existing resource group in which to create the virtual network. The name must follow the Azure CAF convention and start with 'rg-'."
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

variable "location" {
  description = "Azure region in which to create the virtual network, for example 'westeurope'."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]+$", trimspace(var.location)))
    error_message = "The Azure region must be a non-empty canonical region name containing only lowercase letters and numbers, for example 'westeurope'."
  }
}

variable "address_space" {
  description = "One or more non-overlapping IPv4 or IPv6 CIDR prefixes assigned to the virtual network."
  type        = list(string)

  validation {
    condition     = length(var.address_space) <= 20
    error_message = "At least one virtual network address prefix must be specified."
  }

  validation {
    condition     = alltrue([for cidr in var.address_space : can(cidrhost(trimspace(cidr), 0))])
    error_message = "Every address space entry must be a valid IPv4 or IPv6 CIDR prefix."
  }

  validation {
    condition     = length(distinct([for cidr in var.address_space : trimspace(cidr)])) == length(var.address_space)
    error_message = "Address space entries must be unique."
  }
}

variable "dns_servers" {
  description = "Optional ordered list of custom IPv4 DNS server addresses. An empty list uses Azure-provided DNS."
  type        = list(string)
  default     = []

  validation {
    condition     = length(var.dns_servers) <= 9
    error_message = "No more than 9 custom DNS server addresses may be specified."
  }

  validation {
    condition = alltrue([
      for ip in var.dns_servers :
      can(cidrhost("${trimspace(ip)}/32", 0)) && !strcontains(trimspace(ip), ":")
    ])
    error_message = "Every custom DNS server must be a valid IPv4 address without a CIDR prefix."
  }

  validation {
    condition     = length(distinct([for ip in var.dns_servers : trimspace(ip)])) == length(var.dns_servers)
    error_message = "Custom DNS server addresses must be unique."
  }
}

variable "ddos_protection_plan" {
  description = "Optional DDoS Protection Plan association. Set to null to omit the association."
  type = object({
    id     = string
    enable = optional(bool, true)
  })
  default  = null
  nullable = true

  validation {
    condition = (
      var.ddos_protection_plan == null ||
      can(regex(
        "^/subscriptions/[0-9a-fA-F-]{36}/resourceGroups/[^/]+/providers/Microsoft\\.Network/ddosProtectionPlans/[^/]+$",
        trimspace(var.ddos_protection_plan.id)
      ))
    )
    error_message = "The DDoS Protection Plan ID must be a valid Azure resource ID for Microsoft.Network/ddosProtectionPlans."
  }
}

variable "tags" {
  description = "Enterprise tags to apply to the virtual network. Tag keys and values must be non-empty, and Azure supports at most 50 tags per resource."
  type        = map(string)
  default     = {}

  validation {
    condition = (
      length(var.tags) <= 50 &&
      alltrue([
        for key, value in var.tags :
        length(trimspace(key)) > 0 && length(key) <= 512 &&
        length(trimspace(value)) > 0 && length(value) <= 256
      ])
    )
    error_message = "Tags must contain at most 50 entries; keys must be 1-512 characters and values must be 1-256 characters after trimming whitespace."
  }
}
