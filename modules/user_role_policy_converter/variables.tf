variable "policy_arns" {
  type        = any
  description = "A policy arn or a list of policy arns to attach to this role"
  default     = []
}

variable "policy_statements" {
  type        = list(object({ effect = string, actions = list(string), resources = list(string) }))
  description = "A list of policy statements to attach to this role"
  default     = []
}

variable "inline_policy_max_statements" {
  type        = number
  description = "To work around the size limit of inline policy documents, the statements can be partitioned to multiple documents with the given number of statements each. By default, only one document containing all statements will be created."
  default     = 0
}

locals {
  policy_arn_list = flatten([var.policy_arns])

  extracted_statements = length(local.policy_arn_list) > 0 ? [
    for statement in flatten([for policy in data.aws_iam_policy.to_convert : jsondecode(policy.policy)["Statement"]]) : {
      actions   = flatten([lookup(statement, "Action", [])])
      effect    = lookup(statement, "Effect", "Allow")
      resources = flatten([lookup(statement, "Resource", ["*"])])
      conditions = [
        for test, condition in lookup(statement, "Condition", {}) : {
          test     = test
          values   = flatten([values(condition)[0]])
          variable = keys(condition)[0]
        }
      ]
    }
  ] : []

  additional_statements = concat(
    var.policy_statements,
    local.extracted_statements
  )
  max_statements_per_inline_policy = var.inline_policy_max_statements == 0 ? length(local.additional_statements) : var.inline_policy_max_statements
  additional_policy_documents      = chunklist(local.additional_statements, var.inline_policy_max_statements)
}
