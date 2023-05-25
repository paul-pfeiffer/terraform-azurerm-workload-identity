variable "location" {
  type = string
}

variable "name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "identities" {
  type = map(object({
    namespace = string
  }))
}

variable "quick_start_namespace" {
  type = string
}