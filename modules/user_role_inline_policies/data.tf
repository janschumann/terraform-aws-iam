data "aws_iam_policy_document" "policy" {
  count = length(var.documents)

  dynamic "statement" {
    for_each = var.documents[count.index]
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
