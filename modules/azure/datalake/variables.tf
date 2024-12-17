# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

variable "org_code" {
  description = "The organisation code for the environment"
  type        = string
}

variable "tier" {
  description = "Tier of the environment"
  type        = string
}

variable "instance" {
  description = "Identifier for the application, workload or service"
  type        = string
}

variable "tags" {
  description = "Any tags that should be present on created resources. Will get merged with local.default_tags"
  type        = map(string)
  default     = {}
}

variable "resource_group_info" {
  type = object({
    id       = optional(string)
    name     = string
    location = string
  })
  description = "The id, name and location of the Resource Group into which the Datalake should be placed."
}

variable "key_vault_id" {
  description = "ID of the key vault to use for secrets"
  type        = string
}

variable "tenant_id" {
  description = "ID of the tenant to use for secrets"
  type        = string
  default     = ""
}

variable "datalake_ip_whitelist" {
  type        = list(string)
  description = "List of IP addresses to whitelist for access to the datalake"
}

variable "datalake_contributor_group_id" {
  type        = string
  description = "Object ID of the Azure AD Group that should be granted Contributor permissions on the datalake"
}

variable "provision_fileshare" {
  type        = bool
  description = "Whether to provision a fileshare in the datalake"
  default     = false
}

variable "private_link_access_endpoint_resource_ids" {
  type        = list(string)
  description = "List of resource IDs to grant access to the datalake via private link"
  default     = []
}

variable "keyvault_key_name_override" {
  type        = string
  description = "Override the name of the keyvault key to use for encryption"
  default     = null
}

variable "storage_account_name_override" {
  type        = string
  description = "Override the name of the Storage Account to use for the datalake"
  default     = null
}
