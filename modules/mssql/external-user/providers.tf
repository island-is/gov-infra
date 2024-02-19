# Module scaffolded via skyvafnir-module-template by
# Author: gzur
# Version: 0.1.0
# Timestamp: 2023-11-20T14:55:55

terraform {
  required_version = ">= 1.1"

  required_providers {
    mssql = {
      source  = "PGSSoft/mssql"
      version = ">=0.6.0"
    }
  }
}
