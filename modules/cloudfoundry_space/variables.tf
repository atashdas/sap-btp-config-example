variable "labels" {
  description = "List of labels to be applied to new space"
  type        = map(string)
  default     = {}
}

variable "cf_space_config_parameters" {
  description = "Configuration Parameters for Cloudfoundry Space"
  type = map(object({
    cf_region = string
    name      = string
    org_id    = string
    org_name  = string
    auditors = object({
      origin = optional(string),
      users  = list(string)
    })
    developers = object({
      origin = optional(string),
      users  = list(string)
    })
    managers = object({
      origin = optional(string),
      users  = list(string)
    })
    supporters = object({
      origin = optional(string),
      users  = list(string)
    })
  }))
}
