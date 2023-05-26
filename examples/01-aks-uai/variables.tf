variable "location" {
  description = "Location where resources should be created"
  type = string
}

variable "tags" {
  description = "any tags that should be created on the resources"
  type = map(string)
}

variable "identities" {
  description = "define the identity name as key and the namespace name as value ob the object."
  type = map(object({
    namespace = string
    service_account_name = string
  }))
}