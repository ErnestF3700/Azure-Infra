variable "name" {
  description = "Private Endpoint name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "subnet_id" {
  description = "Subnet Resource ID."
  type        = string

  validation {
    condition = can(regex(
      "(?i)^/subscriptions/.+/resourceGroups/.+/providers/Microsoft\\.Network/virtualNetworks/.+/subnets/.+$",
      var.subnet_id
    ))

    error_message = "subnet_id must be a valid Azure Subnet Resource ID."
  }
}

variable "private_connection_resource_id" {
  description = "Target Azure resource Resource ID."
  type        = string
}

variable "subresource_names" {
  description = "Private Link subresources."

  type = list(string)

  validation {
    condition     = length(var.subresource_names) > 0
    error_message = "At least one subresource must be specified."
  }
}

variable "private_dns_zone_group" {
  description = "Optional Private DNS Zone Group."

  type = object({
    name                 = string
    private_dns_zone_ids = list(string)
  })

  default = null
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}
}
