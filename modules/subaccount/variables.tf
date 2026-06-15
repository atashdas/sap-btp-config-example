variable "account_list" {
  description = "Map of subaccount details"
  type = map(object({
    name        = string
    role        = string
    region      = string
    parent_id   = string
    description = string
    subdomain   = optional(string)
    labels      = optional(map(list(string)))
  }))
}

variable "user_role_collection_assignment" {
  description = "List of User and RoleCollection pairs to be assigned"
  type = map(object({
    account_key          = string
    origin               = optional(string)
    user_name            = string
    role_collection_name = string
  }))
  default = {}
}
