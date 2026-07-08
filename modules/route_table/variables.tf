variable "name" {
  description = "Name of the Azure Route Table. For CAF-aligned naming, use a name beginning with `rt-`, such as `rt-hub-prod-weu-001`."
  type        = string
  nullable    = false

  validation {
    condition     = length(var.name) >= 1 && length(var.name) <= 80
    error_message = "The route table name must contain between 1 and 80 characters."
  }

  validation {
    condition     = can(regex("^[A-Za-z0-9](?:[A-Za-z0-9._-]{0,78}[A-Za-z0-9_])?$", var.name))
    error_message = "The route table name must start with an alphanumeric character, end with an alphanumeric character or underscore, and contain only alphanumeric characters, periods, underscores, or hyphens."
  }
}

variable "resource_group_name" {
  description = "Name of the resource group in which to create the Route Table."
  type        = string
  nullable    = false

  validation {
    condition     = length(var.resource_group_name) >= 1 && length(var.resource_group_name) <= 90
    error_message = "The resource group name must contain between 1 and 90 characters."
  }

  validation {
    condition     = can(regex("^[A-Za-z0-9_().-]*[A-Za-z0-9_()-]$", var.resource_group_name))
    error_message = "The resource group name may contain alphanumeric characters, underscores, parentheses, hyphens, and periods, but must not end with a period."
  }
}

variable "location" {
  description = "Azure region in which to create the Route Table, for example `westeurope`."
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.location)) > 0 && var.location == trimspace(var.location)
    error_message = "The location must be a non-empty Azure region name without leading or trailing whitespace."
  }
}

variable "bgp_route_propagation_enabled" {
  description = "Whether routes learned through BGP are propagated to the Route Table."
  type        = bool
  default     = true
  nullable    = false
}

variable "tags" {
  description = "Map of tags to assign to the Route Table. Use organizational tags such as environment, owner, cost center, data classification, and workload where applicable."
  type        = map(string)
  default     = {}
  nullable    = false

  validation {
    condition = alltrue([
      for key, value in var.tags :
      length(trimspace(key)) >= 1 &&
      length(key) <= 512 &&
      length(value) <= 256
    ])
    error_message = "Each tag key must contain 1 to 512 characters and each tag value must contain no more than 256 characters."
  }
}
