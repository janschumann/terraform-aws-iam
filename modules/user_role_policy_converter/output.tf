output "documents" {
  value = data.aws_iam_policy_document.doc.*.statement
}
