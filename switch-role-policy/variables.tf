variable "account_id" {
  type        = string
  description = "The account to switch role to."
}

variable "account_name" {
  type        = string
  description = "The account name to switch role to."
}

variable "role" {
  type        = string
  description = "The role to switch to."
}

variable "groups" {
  type        = list(string)
  description = "A list of group names to allow role switch."
}
