locals {
  # All Cloudfoundry Environments
  cloudfoundry_list = flatten([
    for accCfgKey, accConfig in local.sa_account_config_list : [
      for envKey, env in try(accConfig.details.environments, []) : {
        account_key        = accCfgKey
        account_id         = local.account_details[accCfgKey].id
        account_region     = accConfig.details.region
        cf_name            = env.name
        cf_plan_name       = env.plan_name
        cf_parameters      = env.parameters
        cf_landscape_label = (contains(keys(env), "landscape_label") ? (env.landscape_label != null ? env.landscape_label : "") : "")

        cf_org_list      = try(env.org, [])
        cf_space_list    = try(env.space, [])
        cf_instance_list = try(env.service_instances, [])

        # cf_org_list      = contains(keys(env), "org") ? (env.org != null ? env.org : []) : []
        # cf_space_list    = contains(keys(env), "space") ? (env.space != null ? env.space : []) : []
        # cf_instance_list = contains(keys(env), "service_instances") ? (env.service_instances != null ? env.service_instances : []) : []

      } if envKey == "cloudfoundry"
    ]
  ])

  # Cloudfoundry Environment
  cf_btp_parameters = merge(flatten([
    for cf_item in local.cloudfoundry_list : {
      (format("%s:%s", cf_item.account_key, cf_item.cf_name)) = {
        account_key        = cf_item.account_key
        account_id         = cf_item.account_id
        account_region     = cf_item.account_region
        cf_name            = cf_item.cf_name
        cf_plan_name       = cf_item.cf_plan_name
        cf_parameters      = cf_item.cf_parameters
        cf_landscape_label = cf_item.cf_landscape_label
      }
    }
  ])...)

  # Cloudfoundry Organisation
  cf_org_parameters_us10 = merge(flatten([
    for cf_item in local.cloudfoundry_list : [
      for cf_org in cf_item.cf_org_list : {
        (cf_org.name) = {
          cf_region = cf_item.account_region
          id        = local.cf_org_id_list[cf_org.name]
          # create_new = cf_org.create_new
          auditors = contains(keys(cf_org), "auditors") ? cf_org.auditors != null ? cf_org.auditors : null : null
          managers = contains(keys(cf_org), "managers") ? cf_org.managers != null ? cf_org.managers : null : null
          users    = contains(keys(cf_org), "users") ? cf_org.users != null ? cf_org.users : null : null
        }
      }
    ] if cf_item.account_region == "us10"
  ])...)
  cf_org_parameters_ap21 = merge(flatten([
    for cf_item in local.cloudfoundry_list : [
      for cf_org in cf_item.cf_org_list : {
        (cf_org.name) = {
          cf_region = cf_item.account_region
          id        = local.cf_org_id_list[cf_org.name]
          # create_new = cf_org.create_new
          auditors = contains(keys(cf_org), "auditors") ? cf_org.auditors != null ? cf_org.auditors : null : null
          managers = contains(keys(cf_org), "managers") ? cf_org.managers != null ? cf_org.managers : null : null
          users    = contains(keys(cf_org), "users") ? cf_org.users != null ? cf_org.users : null : null
        }
      }
    ] if cf_item.account_region == "ap21"
  ])...)

  # Cloudfoundry Spaces
  cf_space_parameters_us10 = merge(flatten([
    for cf_item in local.cloudfoundry_list : [
      for cf_space in cf_item.cf_space_list : {
        (format("%s:%s", cf_space.org_name, cf_space.name)) = {
          cf_region = cf_item.account_region
          name      = cf_space.name
          org_id    = local.cf_org_id_list[cf_space.org_name]
          org_name  = cf_space.org_name
          # create_new = cf_space.create_new
          auditors   = contains(keys(cf_space), "auditors") ? cf_space.auditors != null ? cf_space.auditors : null : null
          developers = contains(keys(cf_space), "developers") ? cf_space.developers != null ? cf_space.developers : null : null
          managers   = contains(keys(cf_space), "managers") ? cf_space.managers != null ? cf_space.managers : null : null
          supporters = contains(keys(cf_space), "supporters") ? cf_space.supporters != null ? cf_space.supporters : null : null
        }
      }
    ] if cf_item.account_region == "us10"
  ])...)
  cf_space_parameters_ap21 = merge(flatten([
    for cf_item in local.cloudfoundry_list : [
      for cf_space in cf_item.cf_space_list : {
        (format("%s:%s", cf_space.org_name, cf_space.name)) = {
          cf_region = cf_item.account_region
          name      = cf_space.name
          org_id    = local.cf_org_id_list[cf_space.org_name]
          org_name  = cf_space.org_name
          # create_new = cf_space.create_new
          auditors   = contains(keys(cf_space), "auditors") ? cf_space.auditors != null ? cf_space.auditors : null : null
          developers = contains(keys(cf_space), "developers") ? cf_space.developers != null ? cf_space.developers : null : null
          managers   = contains(keys(cf_space), "managers") ? cf_space.managers != null ? cf_space.managers : null : null
          supporters = contains(keys(cf_space), "supporters") ? cf_space.supporters != null ? cf_space.supporters : null : null
        }
      }
    ] if cf_item.account_region == "ap21"
  ])...)

  # Supported regions check data
  cf_region_list = distinct(flatten([
    for cf in local.cloudfoundry_list : [
      cf.account_region
    ]
  ]))
  cf_supported_region_list = ["us10", "ap21"]
  cf_missing_region_list   = setsubtract(local.cf_region_list, local.cf_supported_region_list)

  # Cloudfoundry API URLs
  cf_api_url_map = merge(flatten([
    for cf_key, cf_params in local.cf_btp_parameters : {
      (cf_params.account_region) = module.cloudfoundry.cf_details[cf_key].cf_api_url
    }
  ])...)

  # Consolidated Cloudfoundry Org & Space IDs
  cf_org_id_list = module.cloudfoundry.cf_orgs
  # cf_sapce_id_list = merge(module.cloudfoundry_space_us10.space_id, module.cloudfoundry_space_ap21.space_id)
}

check "unsupported_regions" {
  assert {
    condition     = length(local.cf_missing_region_list) == 0
    error_message = "Unsupported Cloudfoundry regions: ${join(", ", local.cf_missing_region_list)}. Please add support for these regions."
  }
}

# Cloudfoundry Environments
module "cloudfoundry" {
  source            = "../modules/cloudfoundry"
  cloudfoundry_list = local.cf_btp_parameters
}

# Cloudfoundry Organisations
module "cloudfoundry_org_us10" {
  source    = "../modules/cloudfoundry_org"
  providers = { cloudfoundry = cloudfoundry.us10 }

  cf_org_config_parameters = local.cf_org_parameters_us10
  # cf_org_config_parameters = try(local.cf_org_parameters_by_region.us10, {})  # cf_org_parameters_us10
  # labels                   = local.cf_global_labels # commented out since vales have restrictions

  depends_on = [module.cloudfoundry]
}
module "cloudfoundry_org_ap21" {
  source    = "../modules/cloudfoundry_org"
  providers = { cloudfoundry = cloudfoundry.ap21 }

  cf_org_config_parameters = local.cf_org_parameters_ap21
  # cf_org_config_parameters = try(local.cf_org_parameters_by_region.ap21, {}) # cf_org_parameters_ap21
  # labels                   = local.cf_global_labels # commented out since vales have restrictions

  depends_on = [module.cloudfoundry]
}

# Cloudfoundry Spaces
module "cloudfoundry_space_us10" {
  source    = "../modules/cloudfoundry_space"
  providers = { cloudfoundry = cloudfoundry.us10 }

  cf_space_config_parameters = local.cf_space_parameters_us10
  # labels                     = local.cf_global_labels # commented out since vales have restrictions

  depends_on = [module.cloudfoundry, module.cloudfoundry_org_us10]
}
module "cloudfoundry_space_ap21" {
  source    = "../modules/cloudfoundry_space"
  providers = { cloudfoundry = cloudfoundry.ap21 }

  cf_space_config_parameters = local.cf_space_parameters_ap21
  # labels                     = local.cf_global_labels # commented out since vales have restrictions

  depends_on = [module.cloudfoundry, module.cloudfoundry_org_ap21]
}
