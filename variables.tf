variable "main_account_id" {
  description = "The ID of the main account"
}

variable "associated_accounts" {
  type        = map
  description = "A map of account_name => account_id of associated account"
}

variable "region" {
  default = "eu-central-1"
}
