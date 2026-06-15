locals {
  account_details = merge(flatten([
    for acc_key, acc in var.account_list : {
      (acc_key) = {
        key         = acc_key
        role        = acc.role
        region      = acc.region
        parent_id   = acc.parent_id
        description = acc.description
        labels      = try(acc.labels, {})
        name        = format("%s", lower(replace(acc.name, " ", "-")))

        subdomain = acc.subdomain != null ? acc.subdomain : format("%s", lower(replace(acc.name, " ", "-")))
        # subdomain    = format("%s-%s", acc.name, random_uuid.uuid.result)

        usage        = upper(acc.role) == "PROD" ? "USED_FOR_PRODUCTION" : "NOT_USED_FOR_PRODUCTION"
        beta_enabled = upper(acc.role) == "PROD" ? false : true
      }
    }
  ])...)

  # admin_details = merge(flatten([
  #   for acc_key, acc in var.account_list : [
  #     for admin in acc.administrators : {
  #       (format("%s:%s", acc_key, admin)) = {
  #         key           = acc_key
  #         administrator = admin
  #       }
  #     }
  #   ]
  # ])...)

  # account_trust_list = merge(flatten([
  #   for accKey, idpSetting in var.custom_idp_settings : {
  #     (accKey) = {
  #       name                     = format("CIS (%s) Trust Configuration", split(".", idpSetting.custom_identity_provider)[0])
  #       description              = format("CIS (%s) Trust Configuration", split(".", idpSetting.custom_identity_provider)[0])
  #       link_text                = format("%s Cloud Identity Service (CIS)", split(".", idpSetting.custom_identity_provider)[0])
  #       subaccount_id            = idpSetting.subaccount_id
  #       custom_identity_provider = idpSetting.custom_identity_provider
  #     }
  #   } if idpSetting.custom_identity_provider != null
  # ])...)
}

data "btp_globalaccount" "this" {}

resource "random_uuid" "uuid" {}

resource "btp_subaccount" "this" {
  for_each = local.account_details

  name      = each.value.name
  subdomain = each.value.subdomain
  region    = each.value.region

  usage        = each.value.usage
  beta_enabled = each.value.beta_enabled
  description  = length(each.value.description) == 0 ? null : each.value.description
  parent_id    = length(each.value.parent_id) > 0 ? each.value.parent_id : data.btp_globalaccount.this.id

  labels = merge({
    name = [each.value.name],
    role = [each.value.role]
  }, each.value.labels)
}

# assign a user to a role collection on subaccount level
resource "btp_subaccount_role_collection_assignment" "user_role_collection_assignment" {
  for_each = var.user_role_collection_assignment

  subaccount_id        = btp_subaccount.this[each.value.account_key].id
  role_collection_name = each.value.role_collection_name
  user_name            = each.value.user_name
  origin               = each.value.origin
}
