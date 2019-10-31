resource "aws_iam_account_password_policy" "strict" {
  minimum_password_length        = 24
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = true
  allow_users_to_change_password = true
  hard_expiry                    = true
  max_password_age               = 90
  password_reuse_prevention      = 3
}

resource "aws_iam_group" "this" {
  for_each = toset(local.groups)

  name = each.value
}

resource "aws_iam_user" "this" {
  for_each = toset(local.users)

  name = each.value
}

resource "aws_iam_user_policy" "this" {
  for_each = toset(local.users)

  name   = "AllowSelfUserManagement"
  user   = aws_iam_user.this[each.value].name
  policy = data.aws_iam_policy_document.base_user_policy.json
}

resource "aws_iam_group_membership" "this" {
  for_each = local.groups_users

  name  = each.key
  group = aws_iam_group.this[each.key].name
  users = each.value
}

resource "aws_iam_group_policy" "global_account_administrators" {
  count = local.enabled ? 1 : 0

  name   = "AssumeRoleAccountAdministratorGlobal"
  group  = "GlobalAccountAdministrators"
  policy = data.aws_iam_policy_document.assume_role_global_administrators.json
}

resource "aws_iam_group_policy" "this" {
  for_each = local.assume_role_policies

  name   = format("AssumeRole%s%s", each.value["role"], each.value["account_name"])
  group  = aws_iam_group.this[each.key].name
  policy = data.aws_iam_policy_document.assume_role[each.key].json
}
