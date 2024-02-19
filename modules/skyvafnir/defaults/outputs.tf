output "tags" {
  description = "The tags to be used on the resource."
  value       = local.tags
}

output "resource_name" {
  description = "The name of the resource."
  value       = var.name_override == null ? format(local.resource_name_template, var.resource_abbreviation) : var.name_override
}

output "resource_name_prefixed" {
  description = "The name of the resource with a org_code prefix."
  value       = "${var.org_code}-${format(local.resource_name_template, var.resource_abbreviation)}"
}

output "resource_name_template" {
  description = <<DESC
  The resource name template without the `resource_abbreviation`, i.e.
  `org-<%s>-<
  Use `format` render the template.
  DESC
  value       = local.resource_name_template
}

output "resource_name_template_prefixed" {
  description = "The resource name template. Use `format` render the template.."
  value       = "${var.org_code}-${local.resource_name_template}"
}

output "prefix" {
  description = "The default resource_name prefix - in case you need it."
  value       = split("-", var.prefix)
}

output "suffix" {
  description = "The default resource_name suffix as a list - in case you need it (for the naming module."
  value       = split("-", local.suffix)
}

output "project" {
  description = "The project identifier i.e. [org_code]-[tier]"
  value       = local.project
}
output "environment" {
  description = "The environment identifier i.e. [org_code]-[tier]-[instance]"
  value       = local.environment
}

output "tier_identifier" {
  description = "The tier identifier (empty for production tiers)"
  value       = local.naming_tier
}
