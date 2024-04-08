## Monitor alerts

module "action_group" {
  source = "../monitor-action-group"
  count  = var.enable_db_monitor_alerts ? 1 : 0

  org_code            = var.org_code
  instance            = var.instance
  tier                = var.tier
  resource_group_info = var.resource_group_info

  group_purpose   = "db_alert"
  short_name      = "db_alert"
  email_receivers = var.monitor_alert_emails

  tags = local.tags
}

locals {
  severity = {
    "Informational" = "3",
    "Warning"       = "2",
    "Error"         = "1"
  }
  default_monitor_alerts = {
    # TODO: Look into latency metrics - lock waits / sec according to your friendly neighborhood DBA
    high_user_cpu_usage = {
      # Static
      metric_name = "cpu_percent"
      description = "Alerts when the average CPU usage by the user code exceeds 90%."
      aggregation = "Average"
      operator    = "GreaterThan"
      threshold   = 90
      severity    = local.severity.Warning
    },
    high_total_cpu_usage = {
      # Static
      metric_name = "sql_instance_cpu_percent"
      description = "Triggers an alert when the average total CPU usage of the SQL instance exceeds 90%."
      aggregation = "Average"
      operator    = "GreaterThan"
      threshold   = 90
      severity    = local.severity.Warning
    },
    high_worker_usage = {
      metric_name = "workers_percent"
      description = "Activates when the minimum percentage of SQL workers in use is greater than 60%."
      aggregation = "Minimum"
      operator    = "GreaterThan"
      threshold   = 60
      severity    = local.severity.Error
    },
    high_data_io_usage = {
      metric_name = "physical_data_read_percent"
      description = "Alerts if the average physical data read percentage goes above 90%."
      aggregation = "Average"
      operator    = "GreaterThan"
      threshold   = 90
      severity    = local.severity.Informational
    },
    storage_percent = {
      metric_name = "storage_percent"
      description = "Issues an alert when the minimum storage usage exceeds 95%."
      aggregation = "Minimum"
      operator    = "GreaterThan"
      threshold   = 95
      severity    = local.severity.Error
    },
    low_tempdb_log_space = {
      metric_name = "tempdb_log_used_percent"
      description = "Raises an alert when the minimum percentage of used tempdb log space is greater than 60%."
      aggregation = "Minimum"
      operator    = "GreaterThan"
      threshold   = 60
      severity    = local.severity.Error
    },
    failed_connections_system_errors = {
      metric_name = "connection_failed"
      description = "Alerts on more than 10 failed connections due to system errors."
      aggregation = "Total"
      operator    = "GreaterThan"
      threshold   = 10
      severity    = local.severity.Warning
    },
    deadlocks = {
      metric_name       = "deadlock"
      description       = "Monitors and alerts on deadlock occurrences in the database."
      aggregation       = "Total"
      operator          = "GreaterThan"
      alert_sensitivity = "Medium"
      severity          = local.severity.Informational
    },
    failed_connections_user_errors = {
      metric_name       = "connection_failed_user_error"
      description       = "Alerts on failed connections due to user errors, if they exceed a threshold."
      aggregation       = "Total"
      operator          = "GreaterThan"
      alert_sensitivity = "Medium"
      severity          = local.severity.Warning
    },
    anomalous_connection_rate = {
      metric_name       = "connection_successful"
      description       = "Alerts on unusual rates of successful connections, indicating potential anomalies."
      aggregation       = "Total"
      operator          = "GreaterThan"
      alert_sensitivity = "Low"
      severity          = local.severity.Warning
    }
  }
  #  alerts = var.enable_db_monitor_alerts ? local.default_monitor_alerts : {}
  # Filter out alerts that are not enabled
  enabled_alerts = var.enable_db_monitor_alerts ? {
    for k, v in local.default_monitor_alerts : k => v if !contains(var.disabled_monitor_alerts, k)
  } : {}
}

module "db_alerts" {
  source   = "../monitor-metric-alert"
  for_each = local.enabled_alerts

  instance            = "${each.key}-${var.instance}"
  org_code            = var.org_code
  tier                = var.tier
  resource_group_info = var.resource_group_info

  description = each.value.description

  target_resource_type = "Microsoft.Sql/servers/databases"
  scopes               = [var.resource_group_info.id]
  window_size          = try(each.value.window_size, null)
  frequency            = try(each.value.frequency, null)


  action = {
    action_group_id    = module.action_group[0].action_group_id
    webhook_properties = {}
  }

  criteria = [merge(each.value, { metric_namespace = "Microsoft.Sql/servers/databases" })]

  tags = module.defaults.tags
}