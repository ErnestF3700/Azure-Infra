variable "name" {
  description = "Name of the Federated Identity Credential."
  type        = string

  validation {
    condition     = length(trimspace(var.name)) >= 3 && length(trimspace(var.name)) <= 120
    error_message = "The credential name must contain between 3 and 120 characters."
  }
}

variable "resource_group_name" {
  description = "Resource Group containing the User Assigned Managed Identity."
  type        = string
}

variable "parent_id" {
  description = "Resource ID of the User Assigned Managed Identity."
  type        = string

  validation {
    condition = can(regex(
      "(?i)^/subscriptions/.+/resourceGroups/.+/providers/Microsoft\\.ManagedIdentity/userAssignedIdentities/.+$",
      trimspace(var.parent_id)
    ))

    error_message = "parent_id must be a valid User Assigned Managed Identity Resource ID."
  }
}

variable "issuer" {
  description = "OIDC issuer URL."
  type        = string

  validation {
    condition     = can(regex("^https://", trimspace(var.issuer)))
    error_message = "issuer must be a valid HTTPS URL."
  }
}

variable "subject" {
  description = "OIDC subject."
  type        = string

  validation {
    condition     = length(trimspace(var.subject)) > 0
    error_message = "subject cannot be empty."
  }
}

variable "audiences" {
  description = "OIDC audiences."
  type        = list(string)

  default = [
    "api://AzureADTokenExchange"
  ]

  validation {
    condition     = length(var.audiences) > 0
    error_message = "At least one audience must be specified."
  }
}
