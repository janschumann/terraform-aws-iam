resource "aws_iam_group" "administrators_main" {
  name = "MainAccountAdministrators"
}

resource "aws_iam_group" "administrators_global" {
  name = "GlobalAccountAdministrators"
}

#### Allow role switch
module "main_administrators" {
  source = "./switch-role-policy"

  account_id   = var.main_account_id
  account_name = "Main"
  role         = "AccountAdministrator"
  groups       = [aws_iam_group.administrators_main.name]
}

module "service_test_administrators" {
  source = "./switch-role-policy"

  account_id   = lookup(var.associated_accounts, "service-test")
  account_name = "Service"
  role         = "AccountAdministrator"
  groups       = [aws_iam_group.administrators_global.name]
}
