data "aws_iam_policy_document" "role_switch_policy" {
  version = "2012-10-17"

  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    resources = [
      format("arn:aws:iam::%s:role/%s", var.account_id, var.role)
    ]
  }
}

resource "aws_iam_policy" "this" {
  count = var.enable ? 1 : 0

  name = format("Assume%s%s", var.account_name, var.role)

  policy = data.aws_iam_policy_document.role_switch_policy.json
}

resource "aws_iam_policy_attachment" "this" {
  count = var.enable ? 1 : 0

  name       = aws_iam_policy.this[0].name
  policy_arn = aws_iam_policy.this[0].arn

  groups = var.groups
}
