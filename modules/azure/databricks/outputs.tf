# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

output "workspace_url" {
  description = "The URL of the Databricks workspace"
  value       = azurerm_databricks_workspace.this.workspace_url
}
