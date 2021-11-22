terraform {}

## Variables declaration

variable "object" {
  type        = map(any)
  default     = { "a" : { "b" : { "c" : "d" } } }
  description = ""
}

locals {
  values = flatten([for key1, value1 in var.object : [for key2, value2 in value1 : { for key3, value3 in value2 : "actual_value" => value3 }]])[0]
}

output "key_value" {
  value = local.values["actual_value"]
}
