locals {
  root_path = dirname(abspath(path.root))

  is_config_in_yaml = endswith(var.config_file, ".yaml")
  config_file_path  = format("%s/config/%s", local.root_path, var.config_file)
  config_data       = (fileexists(local.config_file_path) ? local.is_config_in_yaml ? yamldecode(file(local.config_file_path)) : jsondecode(file(local.config_file_path)) : {})

  org_name          = try(local.config_data.landscape.global.org_name, "")
  btp_services      = try(local.config_data.landscape.global.services, {})
  btp_global_labels = { for k, v in try(local.config_data.landscape.global.labels, {}) : k => [v] }
}

check "no_desired_config_file" {
  assert {
    condition     = fileexists(local.config_file_path)
    error_message = "Desired Config file: ${local.config_file_path} is not available!"
  }
}

check "no_globalaccount_subdomain" {
  assert {
    condition     = length(try(local.config_data.landscape.global_account.subdomain, "")) > 0
    error_message = "Globalaccount subdomain is missing in landing-zone configuration."
  }
}
