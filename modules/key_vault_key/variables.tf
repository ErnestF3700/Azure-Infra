variable "name" {
  description = "Name of the Key Vault Key."
  type        = string

  validation {
    condition     = length(trimspace(var.name)) >= 1 && length(trimspace(var.name)) <= 127
    error_message = "The key name must contain between 1 and 127 characters."
  }
}

variable "key_vault_id" {
  description = "Resource ID of the Key Vault."
  type        = string

  validation {
    condition = can(regex(
      "(?i)^/subscriptions/.+/resourceGroups/.+/providers/Microsoft\\.KeyVault/vaults/.+$",
      trimspace(var.key_vault_id)
    ))
    error_message = "key_vault_id must be a valid Azure Key Vault Resource ID."
  }
}

variable "key_type" {
  description = "Type of the Key Vault key."
  type        = string
  default     = "RSA"

  validation {
    condition = contains([
      "RSA",
      "RSA-HSM",
      "EC",
      "EC-HSM",
      "oct"
    ], var.key_type)

    error_message = "Unsupported key type."
  }
}

variable "key_size" {
  description = "RSA key size in bits."
  type        = number
  default     = 2048

  validation {
    condition = contains([
      2048,
      3072,
      4096
    ], var.key_size)

    error_message = "Supported RSA key sizes are 2048, 3072 and 4096."
  }
}

variable "curve" {
  description = "Elliptic Curve name. Used only for EC and EC-HSM keys."
  type        = string
  default     = null

  validation {
    condition = (
      var.curve == null ||
      contains([
        "P-256",
        "P-256K",
        "P-384",
        "P-521"
      ], var.curve)
    )

    error_message = "Unsupported elliptic curve."
  }
}

variable "key_opts" {
  description = "Permitted cryptographic operations."

  type = list(string)

  default = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey"
  ]

  validation {
    condition = alltrue([
      for operation in var.key_opts :
      contains([
        "decrypt",
        "encrypt",
        "sign",
        "unwrapKey",
        "verify",
        "wrapKey"
      ], operation)
    ])

    error_message = "Unsupported key operation."
  }
}

variable "expiration_date" {
  description = "Optional expiration date in RFC3339 format."
  type        = string
  default     = null
}

variable "not_before_date" {
  description = "Optional activation date in RFC3339 format."
  type        = string
  default     = null
}

variable "rotation_policy" {
  description = "Optional automatic key rotation policy."

  type = object({
    expire_after         = string
    notify_before_expiry = string

    automatic = object({
      time_after_creation = optional(string)
      time_before_expiry  = optional(string)
    })
  })

  default = null
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}

  validation {
    condition = (
      length(var.tags) <= 50 &&
      alltrue([
        for key, value in var.tags :
        length(trimspace(key)) > 0 &&
        length(key) <= 512 &&
        length(trimspace(value)) > 0 &&
        length(value) <= 256
      ])
    )

    error_message = "Tags must contain at most 50 entries; keys must be 1-512 characters and values must be 1-256 characters."
  }
}
