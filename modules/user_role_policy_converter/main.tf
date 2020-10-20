data "aws_iam_policy" "to_convert" {
  for_each = toset(local.policy_arn_list)
  arn      = each.value
}

data "aws_iam_policy_document" "doc" {
  count = length(local.additional_policy_documents)

  dynamic "statement" {
    for_each = local.additional_policy_documents[count.index]
    content {
      actions   = lookup(statement.value, "actions", [])
      effect    = lookup(statement.value, "effect", "Allow")
      resources = lookup(statement.value, "resources", ["*"])
      dynamic "condition" {
        for_each = lookup(statement.value, "conditions", [])
        content {
          test     = lookup(condition.value, "test")
          values   = lookup(condition.value, "values")
          variable = lookup(condition.value, "variable")
        }
      }
    }
  }
}
