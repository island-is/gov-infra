# Module scaffolded via skyvafnir-module-template by
# Author: jonorrikristjansson
# Version: 0.1.0
# Timestamp: 2024-01-14T16:44:10

output "databricks_workspace_url" {
  description = "The URL of the Databricks workspace"
  value       = module.databricks_workspace.workspace_url
}
