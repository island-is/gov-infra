# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir
locals {
  resource_abbreviation = "fd"
}

resource "azurerm_cdn_frontdoor_profile" "this" {
  name                = format(module.defaults.resource_name_template, "cdn-profile")
  resource_group_name = var.resource_group_info.name
  sku_name            = "Standard_AzureFrontDoor"

  tags = local.tags
}

resource "azurerm_cdn_frontdoor_endpoint" "this" {
  name                     = format(module.defaults.resource_name_template, "cdn-endpoint")
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this.id

  tags = local.tags
}

resource "azurerm_cdn_frontdoor_origin_group" "this" {
  name                     = format(module.defaults.resource_name_template, "fd-origin-group")
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this.id

  health_probe {
    interval_in_seconds = 30
    protocol            = "Https"
    request_type        = "GET"
    path                = "/live"
  }

  load_balancing {
    additional_latency_in_milliseconds = 0
    sample_size                        = 4
    successful_samples_required        = 2
  }
}

resource "azurerm_cdn_frontdoor_origin" "this" {
  name                           = format(module.defaults.resource_name_template, "fd-origin")
  cdn_frontdoor_origin_group_id  = azurerm_cdn_frontdoor_origin_group.this.id
  enabled                        = true
  certificate_name_check_enabled = true

  host_name          = var.app_service_fqdn
  origin_host_header = var.app_service_fqdn
  http_port          = 80
  https_port         = 443
  priority           = 1
  weight             = 1
}

resource "azurerm_cdn_frontdoor_route" "this" {
  name                          = format(module.defaults.resource_name_template, "fd-route")
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.this.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.this.id]
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.this.id

  supported_protocols = ["Http", "Https"]
  patterns_to_match   = ["/*"]
  forwarding_protocol = "MatchRequest"
}
