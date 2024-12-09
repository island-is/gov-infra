# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

#


locals {
  resource_abbreviation = "dbc"
}

resource "databricks_user" "users" {
  for_each = { for x in var.users : x.user_name => x }

  user_name            = each.value.user_name
  display_name         = each.value.display_name
  allow_cluster_create = false
}

data "databricks_node_type" "this" {
  local_disk = true
}

data "databricks_spark_version" "lts" {
  long_term_support = true
}

resource "databricks_cluster" "cluster" {
  cluster_name            = module.defaults.resource_name
  spark_version           = data.databricks_spark_version.lts.id
  node_type_id            = data.databricks_node_type.this.id
  autotermination_minutes = 20

  autoscale {
    min_workers = 1
    max_workers = 1
  }
}
