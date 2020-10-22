# Terraform module to manage IAM organisation

## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 0.13 |
| aws | ~> 3.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_id | The ID of this account | `string` | n/a | yes |
| accounts | The account and user config | <pre>map(map(object({<br>    account_id = string,<br>    users = map(list(string))<br>  })))</pre> | n/a | yes |
| create\_user\_roles | n/a | `bool` | `true` | no |
| create\_users | n/a | `bool` | `true` | no |
| environment | The name of the environment. If not set `terraform.workspace` will be used. | `string` | `""` | no |
| global\_administrators | A list of users with global admin permissions | `list(string)` | `[]` | no |
| main\_account\_name | The name of the main account. | `string` | `"main"` | no |
| mfa\_auth\_age | n/a | `number` | `3600` | no |
| production\_environment\_name | The name of the production environment. | `string` | `"prod"` | no |
| user\_role\_inline\_policy\_max\_statements | n/a | `number` | `10` | no |
| user\_role\_max\_managed\_policies | n/a | `number` | `10` | no |
| user\_role\_policies | n/a | `map(list(string))` | `{}` | no |
| user\_role\_policy\_statements | n/a | <pre>map(list(object({<br>    effect = string,<br>    actions = list(string),<br>    resources = list(string)<br>  })))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| accounts | A list of account objects. |
| accounts\_by\_environment | A list of account objects by environment. |
| accounts\_by\_type | A list of account objects by account type. |
| associated\_accounts | A list of associated accounts (only in main account). |
| environment | The environment. |
| groups | A list of iam groups (only in main account). |
| groups\_users | A map of group => users relation. |
| user\_role\_names | A list of user role names. |
| user\_role\_policies | A list of manages policies by role. |
| user\_role\_policy\_statements | A list of user policy statements. |
| user\_roles | A map role name => role arn objects. |
| users | A list of iam users (only in main account). |

