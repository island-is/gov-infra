# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir

terraform {
  required_version = ">= 1.1"

  required_providers {
    mssql = {
      source  = "PGSSoft/mssql"
      version = ">=0.6.0"
    }
  }
}
