resource "aws_iam_group_membership" "administrators_global" {
  name = "administrators_global"

  users = [
    aws_iam_user.akersten.name,
    aws_iam_user.cweiss.name,
    aws_iam_user.jschumann.name
  ]

  group = aws_iam_group.administrators_global.name
}

resource "aws_iam_group_membership" "administrators_main" {
  name = "administrators_main"

  users = [
    aws_iam_user.akersten.name,
    aws_iam_user.cweiss.name,
    aws_iam_user.jschumann.name
  ]

  group = aws_iam_group.administrators_main.name
}
