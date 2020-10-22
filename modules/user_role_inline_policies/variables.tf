variable "role" {
  description = "The name of the role."
  type = string
}

variable "documents" {
  description = "A list of objects containing policy statements."
  type    = list(any)
}

