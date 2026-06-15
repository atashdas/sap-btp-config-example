variable "service_list" {
  description = "Service configuration details."
  type = map(object({
    service_name      = string
    plan_name         = string
    app_name          = string
    app_name_override = optional(string)
    amount            = optional(number)
  }))
}

variable "account_service_list" {
  description = "List of services to be deployed and associated details"
  type = map(object({
    subaccount_id = string
    service_name  = string
    parameters    = string
  }))
}

variable "user_role_assignments" {
  description = "Service Role Collections to be assigned to users at subaccount level"
  type = map(object({
    role_collection_name = string
    subaccount_id        = string
    user_name            = string
    origin               = optional(string)
  }))
  default = {}
}

# variable "labels" {
#   description = "Labels to be applied to resources"
#   type        = map(list(string))
#   default     = {}
# }
