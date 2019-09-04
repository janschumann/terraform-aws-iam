resource "aws_iam_user" "akersten" {
  name = "andre.kersten"
}

resource "aws_iam_user" "jschumann" {
  name = "jan.schumann.extern"
}

resource "aws_iam_user" "cweiss" {
  name = "christopher.weiss.extern"
}

resource "aws_iam_policy_attachment" "base_user_policy" {
  name       = "AllowSelfUserManagement"
  policy_arn = aws_iam_policy.base_user_policy.arn

  users = [
    aws_iam_user.akersten.name,
    aws_iam_user.cweiss.name,
    aws_iam_user.jschumann.name,
  ]
}
