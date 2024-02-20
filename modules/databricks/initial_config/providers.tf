# Module scaffolded via skyvafnir-module-template by
# Author: jonorrikristjansson
# Version: 0.1.0
# Timestamp: 2024-01-04T10:40:16

terraform {
  required_version = ">= 1.1"

  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = ">=1.33.0"
    }
  }
}
