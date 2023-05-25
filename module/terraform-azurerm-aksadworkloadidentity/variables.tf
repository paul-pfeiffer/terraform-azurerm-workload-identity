variable "identities" {
  type = map(object({
    namespace = string
  }))
}

variable "location" {
  type = string
}
variable "resource_group_name" {
  type = string
}

variable "aks_oidc_issuer_url" {
  type = string
}

variable "tags" {
  type = map(string)
}