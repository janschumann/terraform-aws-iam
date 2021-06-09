variable "account_id" {
  type        = string
  description = "The ID of this account"
}

variable "accounts" {
  type = map(map(object({
    account_id = string,
    users      = map(list(string))
  })))
  description = "The account and user config"
}

variable "global_administrators" {
  type        = list(string)
  description = "A list of users with global admin permissions"
  default     = []
}

variable "create_users" {
  type    = bool
  default = true
}

variable "user_role_policies" {
  type    = map(list(string))
  default = {}
}

variable "user_role_policy_statements" {
  type = map(list(object({
    effect    = string,
    actions   = list(string),
    resources = list(string)
  })))
  default = {}
}

variable "user_role_max_managed_policies" {
  type    = number
  default = 10
}

variable "user_role_inline_policy_max_statements" {
  type    = number
  default = 10
}

variable "mfa_auth_age" {
  type    = number
  default = 86400
}

variable "create_user_roles" {
  type    = bool
  default = true
}

variable "environment" {
  description = "The name of the environment. If not set `terraform.workspace` will be used."
  type        = string
  default     = ""
}

variable "main_account_name" {
  description = "The name of the main account."
  type        = string
  default     = "main"
}

variable "production_environment_name" {
  description = "The name of the production environment."
  type        = string
  default     = "prod"
}
