# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

variable "org_code" {
  type        = string
  description = "The organization code for the environment"
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
    id       = optional(string, "")
    name     = string
    location = string
  })
  description = "The name and location of the Resource Group into which the Data Factory should be placed."
}

variable "global_parameters" {
  type = list(object({
    name  = string
    type  = string
    value = any
  }))
  description = <<DESC
  A list of global parameters to be added to the Data Factory. These parameters will be available to all pipelines in the Data Factory.
  DESC
  default     = []
}

variable "git_backend_config" {
  description = "Configuration for the github repository"
  type = object({
    type = string # must be either "github" or "azuredevops"

    # Required for Github
    git_url = optional(string)

    # Required for Azure DevOps
    project_name = optional(string)
    tenant_id    = optional(string)

    # General configuration
    account_name    = string
    branch_name     = string
    repository_name = string
    root_folder     = string
  })

  validation {
    # Ensure that type is either github or azuredevops
    condition = var.git_backend_config != null ? contains([
      "azuredevops", "github"
    ], var.git_backend_config.type) : true
    error_message = "data_factory_git_configuration.type must be either 'github' or 'azuredevops'"
  }
  validation {
    # If type == github, git_url is required
    condition     = var.git_backend_config != null ? (var.git_backend_config.type == "github" && var.git_backend_config.git_url != null) || var.git_backend_config.type == "azuredevops" : true
    error_message = "git_url is required when type == 'github'"
  }
  validation {
    # If type == azuredevops, tenant_id and project_name are required
    condition     = var.git_backend_config != null ? (var.git_backend_config.type == "azuredevops" && var.git_backend_config.tenant_id != null && var.git_backend_config.project_name != null) || var.git_backend_config.type == "github" : true
    error_message = "tenant_id and project_name are required when type == 'azuredevops'"
  }
}

variable "datafactory_contributor_group_id" {
  type        = string
  description = "The ID of the group that should be granted contributor access to the Data Factory."
}

variable "datalake_id" {
  type        = string
  description = "The id of the datalake to assign the data factory to."
  default     = ""
}

variable "link_service_to_datalake" {
  type        = bool
  description = "Whether to link the data factory to the datalake via Linked Services."
  default     = false
}

variable "grant_access_to_warehouse" {
  type        = bool
  description = "Whether to grant the the data factory access to the warehouse."
  default     = false
}

variable "warehouse_id" {
  type        = string
  description = "The id the warehouse to assign the data factory to."
  default     = null
}

variable "group_config" {
  type = object({
    purpose = string
    owners  = list(string)
  })
  description = <<DESC
    Configuration for the Entra ID Group that will be created for the Data Factory principal.
    The passed `purpose` will be included in the group name.
    If not provided, no group will be created.
  DESC
  default     = null

  validation {
    condition = (
      # Ensure that group_config is either null, or if provided, its purpose attribute is not an empty string
      var.group_config == null ||
      (var.group_config != null ? var.group_config.purpose != "" : true)
    )
    error_message = "`var.group_config.purpose` must not be the empty string"
  }
}

variable "name_override" {
  type        = string
  description = "Override the name of the Data Factory. If not provided, the name will be generated."
  default     = null
}

variable "alert_on_pipeline_failure" {
  type        = bool
  description = "If true, an alert will be created to notify when a pipeline fails."
  default     = true
}

variable "pipeline_failure_alert_emails" {
  type        = list(string)
  description = "A list of email addresses to notify when a pipeline fails."
  default     = []
}
