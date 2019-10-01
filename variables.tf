variable "enable" {
  type = bool
}

variable "account_id" {
  description = "The ID of this account"
}

variable "associated_accounts" {
  type        = map(string)
  description = "A map of account_name => account_id of associated account"
}

variable "region" {
  default = "eu-central-1"
}
