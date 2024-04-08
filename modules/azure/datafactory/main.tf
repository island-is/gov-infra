# Module scaffolded via skyvafnir-module-template by
# Author: jonorri
# Version: 0.1.0
# Timestamp: 2023-04-29T11:02:31

locals {
  resource_abbreviation = "adf"

  one  = [1]
  zero = []

  # If `var.git_backend_config` is null, set `git_backend_type` to an empty string,
  # which means that no `github_configuration dynamic block will be created/
  git_backend_type = var.git_backend_config != null ? var.git_backend_config.type : ""
}

resource "azurerm_data_factory" "this" {
  name                = var.name_override != null ? var.name_override : module.defaults.resource_name
  location            = var.resource_group_info.location
  resource_group_name = var.resource_group_info.name

  managed_virtual_network_enabled = true
  public_network_enabled          = false

  dynamic "github_configuration" {
    for_each = local.git_backend_type == "github" ? local.one : local.zero
    content {
      account_name    = var.git_backend_config.account_name
      branch_name     = var.git_backend_config.branch_name
      repository_name = var.git_backend_config.repository_name
      root_folder     = var.git_backend_config.root_folder

      git_url = var.git_backend_config.git_url
    }
  }

  dynamic "vsts_configuration" {
    for_each = local.git_backend_type == "azuredevops" ? local.one : local.zero
    content {
      account_name    = var.git_backend_config.account_name
      branch_name     = var.git_backend_config.branch_name
      repository_name = var.git_backend_config.repository_name
      root_folder     = var.git_backend_config.root_folder

      project_name = var.git_backend_config.project_name
      tenant_id    = var.git_backend_config.tenant_id
    }
  }

  dynamic "global_parameter" {
    for_each = var.global_parameters != null ? var.global_parameters : local.zero
    content {
      name  = global_parameter.value.name
      value = global_parameter.value.value
      type  = global_parameter.value.type
    }
  }

  identity {
    type = "SystemAssigned"
  }

  tags = module.defaults.tags

  lifecycle {
    ignore_changes = [
      global_parameter
    ]
  }
}

locals {
  last_index    = length(split("/", var.datalake_id)) - 1
  datalake_name = split("/", var.datalake_id)[local.last_index]
}

data "azurerm_storage_account" "datalake" {
  name                = local.datalake_name
  resource_group_name = var.resource_group_info.name
}

resource "azurerm_data_factory_managed_private_endpoint" "this" {
  count              = var.link_service_to_datalake ? 1 : 0
  name               = "datalake_private_endpoint"
  data_factory_id    = azurerm_data_factory.this.id
  target_resource_id = var.datalake_id
  subresource_name   = "blob"
}

resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "this" {
  count                = var.link_service_to_datalake ? 1 : 0
  name                 = "ls_adl_dev"
  data_factory_id      = azurerm_data_factory.this.id
  url                  = data.azurerm_storage_account.datalake.primary_dfs_endpoint
  use_managed_identity = true
}

module "pipeline_failure_action_group" {
  source = "../monitor-action-group"
  count  = var.alert_on_pipeline_failure == true ? 1 : 0

  tier     = var.tier
  instance = var.instance
  org_code = var.org_code

  resource_group_info = var.resource_group_info

  group_purpose   = "pipeline-alert"
  short_name      = "pipefail"
  email_receivers = var.pipeline_failure_alert_emails
  arm_receiver_role_ids = {
    "Monitoring Reader" = "43d0d8ad-25c7-4714-9337-8ba259a9fe05"
  }

  tags = module.defaults.tags

}

resource "azurerm_monitor_metric_alert" "this" {
  count       = var.alert_on_pipeline_failure == true ? 1 : 0
  name        = format(module.defaults.resource_name_template, "pipeline_fail_alert")
  description = <<DESC
  This alert is triggered when a pipeline fails inside for ${azurerm_data_factory.this.name}
  ${azurerm_data_factory.this.id}
  DESC

  resource_group_name      = var.resource_group_info.name
  target_resource_type     = "Microsoft.DataFactory/factories"
  target_resource_location = var.resource_group_info.location
  scopes                   = [azurerm_data_factory.this.id]

  severity    = 2
  window_size = "PT5M"

  criteria {
    aggregation      = "Total"
    metric_name      = "PipelineFailedRuns"
    metric_namespace = "Microsoft.DataFactory/factories"
    operator         = "GreaterThan"
    threshold        = 0

    dimension {
      name     = "Name"
      operator = "Include"
      values   = ["*"]
    }
  }

  action {
    action_group_id = module.pipeline_failure_action_group[0].action_group_id
  }

  tags = module.defaults.tags
  lifecycle {
    precondition {
      condition     = var.alert_on_pipeline_failure == true && length(var.pipeline_failure_alert_emails) > 0
      error_message = "var.pipeline_failure_alert_emails can't be empty if var.alert_on_pipeline_failure is true."
    }
  }
}
