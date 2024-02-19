# Module scaffolded via skyvafnir-module-template by
# Author: jonorri
# Version: 0.1.0
# Timestamp: 2023-04-29T10:53:38

terraform {
  required_version = ">= 1.1"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.89.0"
    }
    mssql = {
      source  = "PGSSoft/mssql"
      version = "=0.6.0"
    }
  }
}
