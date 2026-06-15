variable "trust_configurations" {
  description = "List of trust config to be applied to subaccount"
  type = map(object({
    subaccount_id     = string
    name              = string
    link_text         = string
    description       = string
    identity_provider = string
  }))
}
