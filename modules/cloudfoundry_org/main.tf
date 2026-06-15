locals {
  cf_auditors = merge(flatten([
    for orgName, params in var.cf_org_config_parameters : [
      for user in try(params.auditors.users, []) : {
        (format("%s:auditor:%s", orgName, user)) = {
          user   = user
          orgId  = params.id
          origin = try(params.auditors.origin, null)
        }
      }
    ]
  ])...)
  cf_managers = merge(flatten([
    for orgName, params in var.cf_org_config_parameters : [
      for user in try(params.managers.users, []) : {
        (format("%s:manager:%s", orgName, user)) = {
          user   = user
          orgId  = params.id
          origin = try(params.managers.origin, null)
        }
      }
    ]
  ])...)
  cf_users = merge(flatten([
    for orgName, params in var.cf_org_config_parameters : [
      for user in try(params.users.users, []) : {
        (format("%s:user:%s", orgName, user)) = {
          user   = user
          orgId  = params.id
          origin = try(params.users.origin, null)
        }
      }
    ]
  ])...)
}

resource "cloudfoundry_org_role" "org_managers" {
  for_each = local.cf_managers

  username = each.value.user
  type     = "organization_manager"
  origin   = each.value.origin
  org      = each.value.orgId
}

resource "cloudfoundry_org_role" "org_users" {
  for_each = local.cf_users

  username = each.value.user
  type     = "organization_user"
  origin   = each.value.origin
  org      = each.value.orgId
}

resource "cloudfoundry_org_role" "org_auditors" {
  for_each = local.cf_auditors

  username = each.value.user
  type     = "organization_auditor"
  origin   = each.value.origin
  org      = each.value.orgId
}
