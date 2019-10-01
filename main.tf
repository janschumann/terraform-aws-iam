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

data "aws_iam_policy_document" "base_user_policy" {
  version = "2012-10-17"

  statement {
    effect = "Allow"
    actions = [
      "iam:ListGroups",
      "iam:ListUsers"
    ]
    resources = [
      format("arn:aws:iam::%s:group/*", var.account_id),
      format("arn:aws:iam::%s:user/*", var.account_id),
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "iam:CreateVirtualMFADevice",
      "iam:DeleteVirtualMFADevice",
      "iam:DeactivateMFADevice",
      "iam:ListGroups",
      "iam:ListUsers",
      "iam:ListVirtualMFADevices",
      "iam:ListMFADevices",
      "iam:EnableMFADevice",
      "iam:DeleteVirtualMFADevice",
      "iam:CreateAccessKey",
      "iam:DeleteAccessKey",
      "iam:ListAccessKeys",
      "iam:UploadSSHPublicKey",
      "iam:UpdateSSHPublicKey",
      "iam:ChangePassword"
    ]
    resources = [
      format("arn:aws:iam::%s:user/$${aws:username}", var.account_id),
      format("arn:aws:iam::%s:mfa/", var.account_id),
      format("arn:aws:iam::%s:mfa/$${aws:username}", var.account_id),
    ]
  }
}

resource "aws_iam_policy" "base_user_policy" {
  count = var.enable ? 1 : 0

  name = "AllowSelfUserManagement"

  policy = data.aws_iam_policy_document.base_user_policy.json
}


