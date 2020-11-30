terraform {
  required_version = ">= 0.12.26"
}

provider "aws" {
  region  = "eu-central-1"
}

variable "account_id" {
  default = "000000000000"
}

module "iam" {
  source = "../../"

  account_id                  = var.account_id
  accounts                    = {
    main = {
      prod = {
        account_id = "000000000000"
        users      = {
          "foo" = [
            "AccountAdministrator"]
        }
      }
    }
    service = {
      test = {
        account_id = "111111111111"
        users = {
          "bar" = ["AccountAdministrator"]
        }
      }
    }
  }
  create_users = false
  create_user_roles = false
}

output "accounts" {
  value = module.iam.accounts
}

output "users" {
  value = module.iam.users
}

output "groups_users" {
  value = module.iam.groups_users
}

output "user_role_names" {
  value = module.iam.user_role_names
}

output "user_role_policy_statements" {
  value = module.iam.user_role_policy_statements
}

output "user_role_policies" {
  value = module.iam.user_role_policies
}
