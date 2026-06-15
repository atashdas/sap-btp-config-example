locals {
  svc_identity_services = merge(flatten([
    for accCfgKey, accConfig in local.sa_account_config_list : [
      contains(keys(accConfig.details), "services") ? (accConfig.details.services != null ? [
        for svc_item in accConfig.details.services : [
          for svcKey, svc in svc_item : {
            (format("%s:%s", accCfgKey, svcKey)) = {
              subaccount_id = local.account_details[accCfgKey].id
              service_name  = svcKey
              parameters    = try(jsonencode(svc.parameters), null)
            }
          }
        ]
      ] : []) : []
    ] if try(accConfig.details.has_identity_service, false) == true
  ])...)

  svc_other_services = merge(flatten([
    for accCfgKey, accConfig in local.sa_account_config_list : [
      contains(keys(accConfig.details), "services") ? (accConfig.details.services != null ? [
        for svc_item in accConfig.details.services : [
          for svcKey, svc in svc_item : {
            (format("%s:%s", accCfgKey, svcKey)) = {
              subaccount_id = local.account_details[accCfgKey].id
              service_name  = svcKey
              parameters    = try(jsonencode(svc.parameters), null)
            }
          }
        ]
      ] : []) : []
    ] if !try(accConfig.details.has_identity_service, false) == true
  ])...)

  svc_user_role_assignments = merge(flatten([
    for accCfgKey, accConfig in local.sa_account_config_list : [
      contains(keys(accConfig.details), "services") ? (accConfig.details.services != null ? [
        for svc_item in accConfig.details.services : [
          for svcKey, svc in svc_item : [
            for roleName, roleConfig in svc.user_role_assignments : [
              for user in roleConfig.users : {
                (format("%s:%s:%s:%s", accCfgKey, svcKey, roleName, user)) = {
                  subaccount_id        = local.account_details[accCfgKey].id
                  role_collection_name = roleName
                  user_name            = user
                  origin               = try(roleConfig.origin, null)
                }
              }
            ]
          ] if try(svc.user_role_assignments, null) != null
        ]
      ] : []) : []
    ]
  ])...)

  ias_svc_custom_idp_host_map = module.identity_services.custom_identity_provider_host_map
  svc_trust_configs = merge(flatten([
    for accCfgKey, accConfig in local.sa_account_config_list : {
      (accCfgKey) = {
        # name              = format("%s-trust", accCfgKey)
        name              = format("CIS (%s) Trust Configuration", split(".", local.ias_svc_custom_idp_host_map[accConfig.details.configure_trust_with].host)[0])
        description       = format("CIS (%s) Trust Configuration", split(".", local.ias_svc_custom_idp_host_map[accConfig.details.configure_trust_with].host)[0])
        link_text         = format("%s Cloud Identity Service (CIS)", local.org_name)
        subaccount_id     = local.account_details[accCfgKey].id
        identity_provider = local.ias_svc_custom_idp_host_map[accConfig.details.configure_trust_with].host
      }
    } if try(accConfig.details.configure_trust, true) == true
  ])...)
}

module "identity_services" {
  source = "../modules/service"

  service_list         = local.btp_services
  account_service_list = local.svc_identity_services
}

module "account_trust_configurations" {
  source               = "../modules/account_trust"
  trust_configurations = local.svc_trust_configs

  depends_on = [module.identity_services]
}

module "other_services" {
  source = "../modules/service"

  service_list          = local.btp_services
  account_service_list  = local.svc_other_services
  user_role_assignments = local.svc_user_role_assignments

  depends_on = [module.account_trust_configurations]
}
