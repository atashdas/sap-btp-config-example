terraform {
  required_version = ">= 1.3.0"

  required_providers {
    btp = {
      source  = "SAP/btp"
      version = ">= 1.0.0"
    }
    cloudfoundry = {
      source  = "cloudfoundry/cloudfoundry"
      version = ">=1.3.0"
    }
  }
}
