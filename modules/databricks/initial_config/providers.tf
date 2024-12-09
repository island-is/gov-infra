# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

#


terraform {
  required_version = ">= 1.1"

  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = ">=1.33.0"
    }
  }
}
