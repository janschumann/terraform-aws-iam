resource "aws_iam_user" "akersten" {
  count = var.enable ? 1 : 0

  name = "andre.kersten"
}

resource "aws_iam_user" "jschumann" {
  count = var.enable ? 1 : 0

  name = "jan.schumann.extern"
}

resource "aws_iam_user" "cweiss" {
  count = var.enable ? 1 : 0

  name = "christopher.weiss.extern"
}

resource "aws_iam_user" "esantos" {
  count = var.enable ? 1 : 0

  name = "eric.santos"
}

resource "aws_iam_policy_attachment" "base_user_policy" {
  count = var.enable ? 1 : 0

  name       = "AllowSelfUserManagement"
  policy_arn = aws_iam_policy.base_user_policy[0].arn

  users = [
    aws_iam_user.akersten[0].name,
    aws_iam_user.cweiss[0].name,
    aws_iam_user.jschumann[0].name,
    aws_iam_user.esantos[0].name,
  ]
}
