# Terraform module to manage IAM organisation

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.33.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iam_user_role"></a> [iam\_user\_role](#module\_iam\_user\_role) | terraform-aws-modules/iam/aws//modules/iam-assumable-role | ~> v3.6.0 |
| <a name="module_iam_user_role_inline_policies"></a> [iam\_user\_role\_inline\_policies](#module\_iam\_user\_role\_inline\_policies) | ./modules/user_role_inline_policies | n/a |
| <a name="module_iam_user_role_policy"></a> [iam\_user\_role\_policy](#module\_iam\_user\_role\_policy) | ./modules/user_role_policy_converter | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_account_password_policy.strict](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy) | resource |
| [aws_iam_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group_membership.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_membership) | resource |
| [aws_iam_group_policy.global_account_administrators](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy) | resource |
| [aws_iam_group_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy) | resource |
| [aws_iam_policy.user_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_user.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy) | resource |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.assume_role_global_administrators](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.base_user_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.user_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | The ID of this account | `string` | n/a | yes |
| <a name="input_accounts"></a> [accounts](#input\_accounts) | The account and user config | <pre>map(map(object({<br>    account_id = string,<br>    users      = map(list(string))<br>  })))</pre> | n/a | yes |
| <a name="input_create_user_roles"></a> [create\_user\_roles](#input\_create\_user\_roles) | n/a | `bool` | `true` | no |
| <a name="input_create_users"></a> [create\_users](#input\_create\_users) | n/a | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The name of the environment. If not set `terraform.workspace` will be used. | `string` | `""` | no |
| <a name="input_global_administrators"></a> [global\_administrators](#input\_global\_administrators) | A list of users with global admin permissions | `list(string)` | `[]` | no |
| <a name="input_main_account_name"></a> [main\_account\_name](#input\_main\_account\_name) | The name of the main account. | `string` | `"main"` | no |
| <a name="input_mfa_auth_age"></a> [mfa\_auth\_age](#input\_mfa\_auth\_age) | n/a | `number` | `86400` | no |
| <a name="input_production_environment_name"></a> [production\_environment\_name](#input\_production\_environment\_name) | The name of the production environment. | `string` | `"prod"` | no |
| <a name="input_user_role_inline_policy_max_statements"></a> [user\_role\_inline\_policy\_max\_statements](#input\_user\_role\_inline\_policy\_max\_statements) | n/a | `number` | `10` | no |
| <a name="input_user_role_max_managed_policies"></a> [user\_role\_max\_managed\_policies](#input\_user\_role\_max\_managed\_policies) | n/a | `number` | `10` | no |
| <a name="input_user_role_policies"></a> [user\_role\_policies](#input\_user\_role\_policies) | n/a | `map(list(string))` | `{}` | no |
| <a name="input_user_role_policy_statements"></a> [user\_role\_policy\_statements](#input\_user\_role\_policy\_statements) | n/a | <pre>map(list(object({<br>    effect    = string,<br>    actions   = list(string),<br>    resources = list(string)<br>  })))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_accounts"></a> [accounts](#output\_accounts) | A list of account objects. |
| <a name="output_accounts_by_environment"></a> [accounts\_by\_environment](#output\_accounts\_by\_environment) | A list of account objects by environment. |
| <a name="output_accounts_by_type"></a> [accounts\_by\_type](#output\_accounts\_by\_type) | A list of account objects by account type. |
| <a name="output_associated_accounts"></a> [associated\_accounts](#output\_associated\_accounts) | A list of associated accounts (only in main account). |
| <a name="output_environment"></a> [environment](#output\_environment) | The environment. |
| <a name="output_groups"></a> [groups](#output\_groups) | A list of iam groups (only in main account). |
| <a name="output_groups_users"></a> [groups\_users](#output\_groups\_users) | A map of group => users relation. |
| <a name="output_user_role_names"></a> [user\_role\_names](#output\_user\_role\_names) | A list of user role names. |
| <a name="output_user_role_policies"></a> [user\_role\_policies](#output\_user\_role\_policies) | A list of manages policies by role. |
| <a name="output_user_role_policy_statements"></a> [user\_role\_policy\_statements](#output\_user\_role\_policy\_statements) | A list of user policy statements. |
| <a name="output_user_roles"></a> [user\_roles](#output\_user\_roles) | A map role name => role arn objects. |
| <a name="output_users"></a> [users](#output\_users) | A list of iam users (only in main account). |
