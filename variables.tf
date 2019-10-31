variable "account_id" {
  description = "The ID of this account"
}

variable "accounts" {
  type        = map(map(object({ account_id = string, users = map(list(string)) })))
  description = "The account and user config"
}

variable "global_administrators" {
  type        = list(string)
  description = "A list of users with global admin permissions"
}

locals {
  main_account_id = flatten([
    for account_type, account in var.accounts : [
      for environment, spec in account : spec["account_id"]
    ] if account_type == "main"
  ])[0]

  enabled = local.main_account_id == var.account_id

  accociated_accounts = local.enabled ? {
    for var in flatten([
      for account_type, account in var.accounts : [
        for environment, spec in account : format("%s-%s:%s", account_type, environment, spec["account_id"])
      ] if account_type != "main"
    ]) : split(":", var)[0] => split(":", var)[1]
  } : {}

  accounts = local.enabled ? flatten([
    for account_type, account in var.accounts : flatten([
      for environment, spec in account : {
        name       = format("%s-%s", account_type, environment)
        account_id = spec["account_id"]
        group = {
          for role in distinct(flatten(values(spec["users"]))) : role => join("", [for part in split("-", account_type != "main" ? format("%s-%s-%ss", account_type, environment, role) : format("%s-%ss", account_type, role)) : title(part)])
        }
      }
    ])
  ]) : []

  groups = local.enabled ? concat([
    "GlobalAccountAdministrators",
    ],
    flatten([for account in local.accounts : values(account["group"])])
  ) : []

  groups_users = local.enabled ? {
    for group in local.groups : group => group == "GlobalAccountAdministrators" ? var.global_administrators : flatten([
      for account_type, account in var.accounts : [
        for environment, spec in account : [
          for user, roles in spec["users"] : [
            for role in roles : user if group == join("", [for part in split("-", account_type != "main" ? format("%s-%s-%ss", account_type, environment, role) : format("%s-%ss", account_type, role)) : title(part)])
          ]
        ]
      ]
    ])
  } : {}

  assume_role_policies = local.enabled ? {
    for group, spec in {
      for group in flatten([for account in local.accounts : values(account["group"])]) : group => group == "GlobalAccountAdministrators" ? [] : flatten([
        for account_type, account in var.accounts : [
          for environment, spec in account : [
            for user, roles in spec["users"] : distinct(flatten([
              for role in roles : {
                account_id   = spec["account_id"]
                account_name = join("", [for part in split("-", account_type != "main" ? format("%s-%s", account_type, environment) : format("%s", account_type)) : title(part)])
                role         = role
              } if group == join("", [for part in split("-", account_type != "main" ? format("%s-%s-%ss", account_type, environment, role) : format("%s-%ss", account_type, role)) : title(part)])
            ]))
          ]
        ]
      ])
    } : group => length(spec) == 0 ? {} : spec[0]
  } : {}

  users = local.enabled ? distinct(flatten([
    for group, users in local.groups_users : [
      for user in users : user
    ]
  ])) : []
}
