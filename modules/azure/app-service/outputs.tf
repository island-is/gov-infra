# Module scaffolded via skyvafnir-module-template by
# Author: jonorrikristjansson
# Version: 0.1.0
# Timestamp: 2024-01-17T13:33:48

output "app_service_identity_principal_id" {
  description = "The principal ID of the identity associated with the App Service"
  value       = length(azurerm_linux_web_app.this.identity) > 0 ? azurerm_linux_web_app.this.identity[0].principal_id : 0
}

output "app_service_identity_tenant_id" {
  description = "The tenant ID of the identity associated with the App Service"
  value       = length(azurerm_linux_web_app.this.identity) > 0 ? azurerm_linux_web_app.this.identity[0].tenant_id : 0
}
