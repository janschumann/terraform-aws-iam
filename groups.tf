resource "aws_iam_group" "administrators_main" {
  name = "MainAccountAdministrators"
}

resource "aws_iam_group" "administrators_global" {
  name = "GlobalAccountAdministrators"
}

#### Allow role switch
module "main_administrators" {
  source = "./switch-role-policy"

  account_id   = var.account_id
  account_name = "Main"
  role         = "AccountAdministrator"
  groups       = [aws_iam_group.administrators_main.name]
}

