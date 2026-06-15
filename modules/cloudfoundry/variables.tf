variable "cloudfoundry_list" {
  description = "List of CF environments"
  type = map(object({
    account_key        = string
    account_id         = string
    account_region     = string
    cf_landscape_label = string
    cf_name            = string
    cf_parameters = object({
      instance_name = string
    })
    cf_plan_name = string
  }))
}
