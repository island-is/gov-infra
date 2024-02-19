variable "tier" {
  description = "Tier identifier (e.g. dev, test, prod)"
  type        = string
}

variable "org_code" {
  description = "The organisation code for the environment"
  type        = string
}

variable "instance" {
  description = "The instance of the environment"
  type        = string
}

variable "resource_group_info" {
  description = "The name and location of the Resource Group into which the Key Vault should be placed."
  type = object({
    id       = string
    name     = string
    location = string
  })
}

variable "tenant_id" {
  description = "The Azure AD tenant ID that should be used for authenticating requests to the key vault. Leave blank to use the current Tenant ID"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Any tags that should be present on created resources. Will get merged with local.default_tags"
  type        = map(string)
  default     = {}
}

variable "keyvault_ip_whitelist" {
  description = "List of IP addresses that should be whitelisted to access the Key Vault"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "keyvault_admin_principal_id" {
  description = <<DESC
  The Object ID of the user or service principal that should be granted Key Vault Administrator permissions
  DEPRECATED: Use keyvault_admin_ids (a list) instead.
  DESC
  type        = string
  default     = null
}

variable "keyvault_admin_principal_ids" {
  description = "List of Object IDs of the users or service principals that should be granted Key Vault Administrator permissions"
  type        = list(string)
  default     = []
}

variable "keyvault_secret_contributors" {
  type        = map(string)
  description = <<DESC
  A map of free-form identifiers to Entra Object IDs of Entra Users / Service Principals / Managed Identities that should be granted Key Vault Secret **Contributor** permissions.
  Example:
  ```.hcl
    {
        "Group Name"   = "<user-entra-object-id>"
        "Data Factory" = "<data-factory-service-principal-object-id>"
    }
  ```
  DESC
  default     = {}
}

variable "keyvault_secret_readers" {
  description = <<DESC
  A map of free-form identifiers to Entra Object IDs of Entra Users / Service Principals / Managed Identities that should be granted Key Vault Secret **Reader** permissions.
  Example:
  ```.hcl
    {
        "Group Name"   = "<user-entra-object-id>"
        "Data Factory" = "<data-factory-service-principal-object-id>"
    }
  ```
  DESC
  type        = map(string)
  default     = {}
}

variable "keyvault_name_override" {
  description = "Override the name of the Key Vault. Leave blank to use the default naming convention."
  type        = string
  default     = null
}
