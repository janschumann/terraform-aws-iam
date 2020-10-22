resource "aws_iam_role_policy" "policy" {
  count = length(data.aws_iam_policy_document.policy.*)

  name_prefix = format("%sInlinePolicy", var.role)
  role        = format("%s", var.role)
  policy      = data.aws_iam_policy_document.policy[count.index].json
}
