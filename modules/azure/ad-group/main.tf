# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

locals {
  # Change this to match your resource.
  # https://github.com/MicrosoftDocs/cloud-adoption-framework/blob/main/docs/ready/azure-best-practices/resource-abbreviations.md
  resource_abbreviation = "adg"
  group_name            = "${module.defaults.resource_name}-${var.group_purpose}"
  group_description = trimprefix( # Trim separator if var.group_description is empty.
    join(
      " - ",
      [
        var.group_description,
        "Environment: ${module.defaults.environment}",
        "Provisioned by terraform via ${basename(path.cwd)}. Module: ${basename(path.module)}.",
      ]
    ), #/join
    " - "
  ) # /trimprefix

  provision_group = var.existing_group_name == "" ? true : false
  group_info = {
    group_id   = local.provision_group ? azuread_group.this[0].object_id : data.azuread_group.this[0].object_id
    group_name = local.provision_group ? azuread_group.this[0].display_name : data.azuread_group.this[0].display_name
  }
}

# Create a Azure Security Group
resource "azuread_group" "this" {
  count = var.existing_group_name == "" ? 1 : 0

  display_name     = local.group_name
  owners           = var.group_owner_principal_ids
  description      = local.group_description
  security_enabled = true
}

# Alternatively, use an existing Azure Security Group
data "azuread_group" "this" {
  count        = var.existing_group_name != "" ? 1 : 0
  display_name = var.existing_group_name
}

# Assign the users to the group
resource "azuread_group_member" "this" {
  count            = length(var.group_member_principal_ids)
  group_object_id  = local.group_info.group_id
  member_object_id = var.group_member_principal_ids[count.index]
}
