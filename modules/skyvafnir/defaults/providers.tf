terraform {
  required_version = ">= 1.1"

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">=3.0.0"
    }
  }
}
