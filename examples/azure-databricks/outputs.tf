# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

output "databricks_workspace_url" {
  description = "The URL of the Databricks workspace"
  value       = module.databricks_workspace.workspace_url
}
