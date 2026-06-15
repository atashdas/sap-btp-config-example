variable "cf_org_config_parameters" {
  description = "Configuration Parameters for Cloudfoundry org"
  type = map(object({
    cf_region = string
    id        = string
    auditors = object({
      origin = optional(string)
      users  = list(string)
    })
    managers = object({
      origin = optional(string)
      users  = list(string)
    })
    users = object({
      origin = optional(string)
      users  = list(string)
    })
  }))
}
