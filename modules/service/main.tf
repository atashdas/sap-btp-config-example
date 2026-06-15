locals {
  svc_applications = merge(flatten([
    for itemKey, item in var.account_service_list : {
      (itemKey) = {
        subaccount_id     = item.subaccount_id
        parameters        = item.parameters
        app_name          = var.service_list[item.service_name].app_name
        app_name_override = try(var.service_list[item.service_name].app_name_override, null)
        service_name      = var.service_list[item.service_name].service_name
        app_plan_name     = var.service_list[item.service_name].plan_name
        amount            = try(var.service_list[item.service_name].amount, null)
      }
    }
  ])...)
}

# Service Applications
resource "btp_subaccount_entitlement" "service_application" {
  for_each = local.svc_applications

  subaccount_id = each.value.subaccount_id
  service_name  = each.value.app_name
  plan_name     = each.value.app_plan_name
  amount        = try(each.value.amount, null)
}

resource "btp_subaccount_subscription" "service_application" {
  for_each = local.svc_applications

  subaccount_id = each.value.subaccount_id
  plan_name     = each.value.app_plan_name
  app_name      = each.value.app_name_override == null ? each.value.app_name : each.value.app_name_override
  parameters    = each.value.parameters

  timeouts = {
    create = "30m"
  }

  depends_on = [btp_subaccount_entitlement.service_application]
}

# User to a service role collection assignment at subaccount level
resource "btp_subaccount_role_collection_assignment" "user_role_collection_assignment" {
  for_each = var.user_role_assignments

  role_collection_name = each.value.role_collection_name
  subaccount_id        = each.value.subaccount_id
  user_name            = each.value.user_name
  origin               = each.value.origin

  depends_on = [btp_subaccount_subscription.service_application]
}
