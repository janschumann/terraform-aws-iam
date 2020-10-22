output "accounts" {
  description = "A list of account objects."
  value = local.accounts
}

output "accounts_by_type" {
  description = "A list of account objects by account type."
  value = {
    for a in local.accounts : a["type"] => a...
  }
}

output "accounts_by_environment" {
  description = "A list of account objects by environment."
  value = {
    for a in local.accounts : a["environment"] => a...
  }
}

output "environment" {
  description = "The environment."
  value = local.environment
}

output "associated_accounts" {
  description = "A list of associated accounts (only in main account)."
  value = local.associated_accounts
}

output "groups" {
  description = "A list of iam groups (only in main account)."
  value = local.groups
}

output "users" {
  description = "A list of iam users (only in main account)."
  value = local.users
}

output "groups_users" {
  description = "A map of group => users relation."
  value = local.groups_users
}

output "user_role_names" {
  description = "A list of user role names."
  value = local.user_role_names
}

output "user_role_policy_statements" {
  description = "A list of user policy statements."
  value = local.user_role_policy_statements
}

output "user_role_policies" {
  description = "A list of manages policies by role."
  value = local.user_role_policies
}

output "user_roles" {
  description = "A map role name => role arn objects."
  value = {
    for role_name, role in module.iam_user_role : role_name => role.this_iam_role_arn
  }
}
