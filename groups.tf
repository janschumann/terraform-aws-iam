resource "aws_iam_group" "administrators_main" {
  count = var.enable ? 1 : 0

  name = "MainAccountAdministrators"
}

resource "aws_iam_group" "administrators_global" {
  count = var.enable ? 1 : 0

  name = "GlobalAccountAdministrators"
}

#### Allow role switch
module "main_administrators" {
  source = "./switch-role-policy"

  enable       = var.enable
  account_id   = var.account_id
  account_name = "Main"
  role         = "AccountAdministrator"
  groups       = [var.enable ? aws_iam_group.administrators_main[0].name : ""]
}

module "service_test_administrators" {
  source = "./switch-role-policy"

  enable       = var.enable
  account_id   = lookup(var.associated_accounts, "service-test", "")
  account_name = "Service"
  role         = "AccountAdministrator"
  groups       = [var.enable ? aws_iam_group.administrators_global[0].name : ""]
}
