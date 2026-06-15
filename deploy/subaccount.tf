locals {
  # All Subaccounts
  sa_l0_account_configs = merge(flatten([
    for key, account in lookup(try(local.config_data.landscape, {}), "accounts", {}) : {
      (key) = { details = account, parent_id = data.btp_globalaccount.this.id }
    } if try(local.config_data.landscape.accounts, null) != null
  ])...)
  sa_l1_account_configs = merge(flatten([
    for l1_key, l1_dir in lookup(try(local.config_data.landscape, {}), "directories", {}) : [
      for key, account in lookup(l1_dir, "accounts", {}) : {
        (key) = { details = account, parent_id = module.directory.directory_list[l1_key].id }
    }]
  ])...)
  sa_l2_account_configs = merge(flatten([
    for l1_key, l1_dir in lookup(try(local.config_data.landscape, {}), "directories", {}) : [
      for l2_key, l2_dir in lookup(try(l1_dir, {}), "directories", {}) : [
        for key, account in lookup(l2_dir, "accounts", {}) : {
          (key) = { details = account, parent_id = module.directory.directory_list[format("%s>%s", l1_key, l2_key)].id }
      }]
    ]
  ])...)
  sa_account_config_list = merge(local.sa_l0_account_configs, local.sa_l1_account_configs, local.sa_l2_account_configs)

  sa_account_list = merge(flatten([
    for accCfgKey, accConfig in local.sa_account_config_list : {
      (accCfgKey) = {
        name        = accCfgKey
        parent_id   = accConfig.parent_id
        role        = accConfig.details.role
        region      = accConfig.details.region
        description = accConfig.details.description
        subdomain   = try(accConfig.details.subdomain, null)
        labels      = merge(local.btp_global_labels, try(accConfig.details.labels, null) != null ? { for k, v in accConfig.details.labels : k => [v] } : {})

        user_role_assignments = try(accConfig.details.user_role_assignments, {})
      }
    }
  ])...)

  # User Role Assignments
  sa_ac_user_role_assignmment_list = merge(flatten([
    for accKey, acc in local.sa_account_list : [
      for roleName, roleConfig in acc.user_role_assignments : [
        for user in roleConfig.users : {
          (format("%s:%s:%s", accKey, roleName, user)) = {
            account_key          = accKey
            user_name            = user
            origin               = try(roleConfig.origin, null)
            role_collection_name = roleName
          }
        }
      ]
    ]
  ])...)

  # Subaccount details for accounts created
  account_details = merge(flatten([module.subaccount.account_details])...)
}

data "btp_globalaccount" "this" {}

module "subaccount" {
  source = "../modules/subaccount"

  account_list                    = local.sa_account_list
  user_role_collection_assignment = local.sa_ac_user_role_assignmment_list
}
