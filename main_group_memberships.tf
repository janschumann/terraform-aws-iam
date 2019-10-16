resource "aws_iam_group_membership" "administrators_global" {
  count = var.enable ? 1 : 0

  name = "administrators_global"

  users = [
    aws_iam_user.akersten[0].name,
    aws_iam_user.cweiss[0].name,
    aws_iam_user.jschumann[0].name,
    aws_iam_user.esantos[0].name,
  ]

  group = aws_iam_group.administrators_global[0].name
}

resource "aws_iam_group_membership" "administrators_main" {
  count = var.enable ? 1 : 0

  name = "administrators_main"

  users = [
    aws_iam_user.akersten[0].name,
    aws_iam_user.cweiss[0].name,
    aws_iam_user.jschumann[0].name,
    aws_iam_user.esantos[0].name,
  ]

  group = aws_iam_group.administrators_main[0].name
}
