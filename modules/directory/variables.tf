variable "l1_directories" {
  description = "List of level 1 directories"
  type = map(object({
    name        = string
    description = string
    feature     = list(string)
    parent_name = string
    labels      = map(list(string))
  }))
}

variable "l2_directories" {
  description = "List of level 2 directories"
  type = map(object({
    name        = string
    description = string
    feature     = list(string)
    parent_name = string
    labels      = map(list(string))
  }))
}
