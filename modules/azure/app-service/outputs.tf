# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

#


output "app_service_identity_principal_id" {
  description = "The principal ID of the identity associated with the App Service"
  value       = length(azurerm_linux_web_app.this.identity) > 0 ? azurerm_linux_web_app.this.identity[0].principal_id : 0
}

output "app_service_identity_tenant_id" {
  description = "The tenant ID of the identity associated with the App Service"
  value       = length(azurerm_linux_web_app.this.identity) > 0 ? azurerm_linux_web_app.this.identity[0].tenant_id : 0
}

output "app_service_fqdn" {
  description = "The FQDN of the App Service"
  value       = azurerm_linux_web_app.this.default_hostname
}

output "app_service_plan_id" {
  description = "The ID of the App Service Plan"
  value       = var.existing_service_plan_id != "" ? var.existing_service_plan_id : azurerm_service_plan.this[0].id
}
