variable "name" {
  description = "Firewall Rule Collection Group name."
  type        = string
}

variable "firewall_policy_id" {
  description = "Firewall Policy Resource ID."
  type        = string
}

variable "priority" {
  description = "Rule Collection Group priority."
  type        = number
}

variable "application_rule_collections" {
  description = "Application Rule Collections."

  type = list(object({
    name     = string
    priority = number
    action   = string

    rules = list(object({
      name = string

      source_addresses = list(string)

      destination_fqdns = list(string)

      protocol = object({
        type = string
        port = number
      })
    }))
  }))

  default = []
}

variable "network_rule_collections" {

  description = "Network Rule Collections."

  type = list(object({

    name     = string
    priority = number
    action   = string

    rules = list(object({

      name = string

      protocols = list(string)

      source_addresses = list(string)

      destination_addresses = list(string)

      destination_ports = list(string)

    }))
  }))

  default = []
}

variable "nat_rule_collections" {

  description = "NAT Rule Collections."

  type = list(object({

    name     = string
    priority = number
    action   = string

    rules = list(object({

      name = string

      protocols = list(string)

      source_addresses = list(string)

      destination_address = string

      destination_ports = list(string)

      translated_address = string

      translated_port = string

    }))
  }))

  default = []
}
