variable "name" {
  description = "Name of the Local Network Gateway."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "gateway_address" {
  description = "Public IPv4 address of the on-premises VPN device."
  type        = string

  validation {
    condition     = can(cidrhost("${var.gateway_address}/32", 0))
    error_message = "gateway_address must be a valid IPv4 address."
  }
}

variable "address_space" {
  description = "One or more on-premises network prefixes."
  type        = list(string)

  validation {
    condition = alltrue([
      for cidr in var.address_space :
      can(cidrhost(cidr, 0))
    ])

    error_message = "All address_space values must be valid CIDR prefixes."
  }

  validation {
    condition     = length(distinct(var.address_space)) == length(var.address_space)
    error_message = "Address space prefixes must be unique."
  }
}

variable "bgp_settings" {
  description = "Optional BGP settings."
  type = object({
    asn                 = number
    bgp_peering_address = string
    peer_weight         = optional(number, 0)
  })

  default = null

  validation {
    condition = (
      var.bgp_settings == null ||
      (
        var.bgp_settings.asn >= 1 &&
        var.bgp_settings.asn <= 4294967295
      )
    )

    error_message = "ASN must be between 1 and 4294967295."
  }

  validation {
    condition = (
      var.bgp_settings == null ||
      can(cidrhost("${var.bgp_settings.bgp_peering_address}/32", 0))
    )

    error_message = "bgp_peering_address must be a valid IPv4 address."
  }

  validation {
    condition = (
      var.bgp_settings == null ||
      (
        var.bgp_settings.peer_weight >= 0 &&
        var.bgp_settings.peer_weight <= 100
      )
    )

    error_message = "peer_weight must be between 0 and 100."
  }
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}
}
