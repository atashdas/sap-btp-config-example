data "btp_subaccount_environments" "all" {
  for_each      = var.cloudfoundry_list
  subaccount_id = each.value.account_id
}

resource "terraform_data" "cf_landscape_label" {
  for_each = var.cloudfoundry_list

  input = (length(each.value.cf_landscape_label) > 0
    ? each.value.cf_landscape_label
    : [
      for env in data.btp_subaccount_environments.all[each.key].values : env
      if env.service_name == "cloudfoundry" && env.environment_type == "cloudfoundry"
  ][0].landscape_label)

  depends_on = [data.btp_subaccount_environments.all]
}

resource "btp_subaccount_environment_instance" "this" {
  for_each = var.cloudfoundry_list

  environment_type = "cloudfoundry"
  service_name     = "cloudfoundry"
  name             = each.value.cf_name
  plan_name        = each.value.cf_plan_name
  subaccount_id    = each.value.account_id
  landscape_label = (length(each.value.cf_landscape_label) > 0
    ? each.value.cf_landscape_label
  : terraform_data.cf_landscape_label[each.key].output)

  parameters = jsonencode(each.value.cf_parameters)

  timeouts = {
    create = "1h"
    update = "30m"
    delete = "30m"
  }
}
