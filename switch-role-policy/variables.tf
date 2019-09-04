variable "account_id" {
  description = "The account to switch role to."
}

variable "account_name" {
  description = "The account name to switch role to."
}

variable "role" {
  description = "The role to switch to."
}

variable "groups" {
  type        = list(string)
  description = "A list of group names to allow role switch."
}
