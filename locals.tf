locals {
  environment = var.environment != "" ? var.environment : terraform.workspace

  main_account_id = flatten([
    for account_type, account in var.accounts : [
      for environment, spec in account : spec["account_id"] if environment == var.production_environment_name
    ] if account_type == var.main_account_name
  ])[0]

  create_users = local.main_account_id == var.account_id && var.create_users

  associated_accounts = {
    for var in flatten([
      for account_type, account in var.accounts : [
        for environment, spec in account : format("%s-%s:%s", account_type, environment, spec["account_id"])
      ] if account_type != var.main_account_name && local.main_account_id == var.account_id
    ]) : split(":", var)[0] => split(":", var)[1]
  }

  accounts = flatten([
    for account_type, account in var.accounts : flatten([
      for environment, spec in account : {
        name        = format("%s-%s", account_type, environment)
        type        = account_type
        environment = environment
        account_id  = spec["account_id"]
        group = {
          for role in distinct(flatten(values(spec["users"]))) : role => join("", [for part in split("-", account_type != var.main_account_name ? format("%s-%s-%ss", account_type, environment, role) : format("%s-%ss", account_type, role)) : title(part)])
        }
      }
    ])
  ])

  groups = concat(["GlobalAccountAdministrators"],
    flatten([for account in local.accounts : values(account["group"])])
  )

  groups_users = {
    for group in local.groups : group => group == "GlobalAccountAdministrators" ? var.global_administrators : flatten([
      for account_type, account in var.accounts : [
        for environment, spec in account : [
          for user, roles in spec["users"] : [
            for role in roles : user if group == join("", [for part in split("-", account_type != var.main_account_name ? format("%s-%s-%ss", account_type, environment, role) : format("%s-%ss", account_type, role)) : title(part)])
          ]
        ]
      ]
    ])
  }

  assume_role_policies = {
    for group, spec in {
      for group in flatten([for account in local.accounts : values(account["group"])]) : group => group == "GlobalAccountAdministrators" ? [] : flatten([
        for account_type, account in var.accounts : [
          for environment, spec in account : [
            for user, roles in spec["users"] : distinct(flatten([
              for role in roles : {
                account_id   = spec["account_id"]
                account_name = join("", [for part in split("-", account_type != var.main_account_name ? format("%s-%s", account_type, environment) : format("%s", account_type)) : title(part)])
                role         = role
              } if group == join("", [for part in split("-", account_type != var.main_account_name ? format("%s-%s-%ss", account_type, environment, role) : format("%s-%ss", account_type, role)) : title(part)])
            ]))
          ]
        ]
      ])
    } : group => length(spec) == 0 ? {} : spec[0]
  }

  users = distinct(flatten([
    for group, users in local.groups_users : [
      for user in users : user
    ]
  ]))

  user_role_names = distinct(concat(["AccountAdministrator"], flatten([
    for account in local.accounts : keys(account["group"]) if account["environment"] == local.environment && account["account_id"] == var.account_id
  ])))

  user_role_policy_statements = {
    for role, statements in var.user_role_policy_statements : role => statements if contains(local.user_role_names, role) && length(statements) > 0
  }

  user_role_policies = merge({
    AccountAdministrator = [
      "arn:aws:iam::aws:policy/AdministratorAccess"
    ]
  }, {
    for role, statements in local.user_role_policy_statements : role => [
      format("arn:aws:iam::%s:policy/%s", var.account_id, role)
    ]
  })

  user_roles = {
    for role in local.user_role_names : role => distinct(flatten(compact(concat(
      length(lookup(local.user_role_policies, role, [])) > 0 ? local.user_role_policies[role] : [],
      length(lookup(var.user_role_policies, role, [])) > 0 ? var.user_role_policies[role] : []
    )))) if length(lookup(local.user_role_policies, role, [])) > 0 || length(lookup(var.user_role_policies, role, [])) > 0
  }
}
