terraform {
  required_version = ">= 1.3.0"

  required_providers {
    btp = {
      source  = "SAP/btp"
      version = ">= 1.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.0"
    }
  }
}
