# Please checkout documentation on how best to authenticate against SAP BTP in Terraform provider for SAP BTP
# Get the global account dynamically from btp-landing-zone config file
provider "btp" {
  globalaccount = local.config_data.landscape.global_account.subdomain
}

# Cloudfoundry providers
provider "cloudfoundry" {
  alias   = "ap21"
  api_url = try(local.cf_api_url_map["ap21"], "https://api.cf.ap21.hana.ondemand.com")
}
provider "cloudfoundry" {
  alias   = "us10"
  api_url = try(local.cf_api_url_map["us10"], "https://api.cf.us10-001.hana.ondemand.com")
}
