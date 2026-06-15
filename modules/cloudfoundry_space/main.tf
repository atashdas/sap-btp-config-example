locals {
  cf_auditors = merge(flatten([
    for key, params in var.cf_space_config_parameters : [
      for user in try(params.auditors.users, []) : {
        (format("%s:%s:auditor:%s", params.org_name, params.name, user)) = {
          space_id_key = key
          user         = user
          spaceName    = params.name
          origin       = try(params.auditors.origin, null)
        }
      }
    ]
  ])...)
  cf_developers = merge(flatten([
    for key, params in var.cf_space_config_parameters : [
      for user in try(params.developers.users, []) : {
        (format("%s:%s:developer:%s", params.org_name, params.name, user)) = {
          space_id_key = key
          user         = user
          spaceName    = params.name
          origin       = try(params.developers.origin, null)
        }
      }
    ]
  ])...)
  cf_managers = merge(flatten([
    for key, params in var.cf_space_config_parameters : [
      for user in try(params.managers.users, []) : {
        (format("%s:%s:manager:%s", params.org_name, params.name, user)) = {
          space_id_key = key
          user         = user
          spaceName    = params.name
          origin       = try(params.managers.origin, null)
        }
      }
    ]
  ])...)
  cf_supporters = merge(flatten([
    for key, params in var.cf_space_config_parameters : [
      for user in try(params.supporters.users, []) : {
        (format("%s:%s:supporter:%s", params.org_name, params.name, user)) = {
          space_id_key = key
          user         = user
          spaceName    = params.name
          origin       = try(params.supporters.origin, null)
        }
      }
    ]
  ])...)
}

resource "cloudfoundry_space" "space" {
  for_each = var.cf_space_config_parameters

  name      = each.value.name
  org       = each.value.org_id
  allow_ssh = "true"
  labels    = merge({ name : each.value.name }, var.labels)

  lifecycle {
    ignore_changes = [org, labels]
  }
}

resource "cloudfoundry_space_role" "space_managers" {
  for_each = local.cf_managers

  username = each.value.user
  type     = "space_manager"
  origin   = try(each.value.origin, null)
  space    = cloudfoundry_space.space[each.value.space_id_key].id
}

resource "cloudfoundry_space_role" "space_developers" {
  for_each = local.cf_developers

  username = each.value.user
  type     = "space_developer"
  origin   = try(each.value.origin, null)
  space    = cloudfoundry_space.space[each.value.space_id_key].id
}

resource "cloudfoundry_space_role" "space_auditors" {
  for_each = local.cf_auditors

  username = each.value.user
  type     = "space_auditor"
  origin   = try(each.value.origin, null)
  space    = cloudfoundry_space.space[each.value.space_id_key].id
}

resource "cloudfoundry_space_role" "space_supporters" {
  for_each = local.cf_supporters

  username = each.value.user
  type     = "space_supporter"
  origin   = try(each.value.origin, null)
  space    = cloudfoundry_space.space[each.value.space_id_key].id
}
