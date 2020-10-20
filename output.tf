output "accounts" {
  value = local.accounts
}

output "accounts_by_type" {
  value = {
    for a in local.accounts : a["type"] => a...
  }
}

output "accounts_by_environment" {
  value = {
    for a in local.accounts : a["environment"] => a...
  }
}

output "associated_accounts" {
  value = local.associated_accounts
}

output "user_roles" {
  value = {
    for role_name, role in module.iam_user_role : role_name => role.this_iam_role_arn
  }
}

output "user_roles_documents" {
  value = {
    for role, output in module.iam_user_role_policy : role => output["documents"] if length(output["documents"]) > 0
  }
}
