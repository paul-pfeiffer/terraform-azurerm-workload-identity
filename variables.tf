variable "identities" {
  description = "define the identity name as key and the namespace name as value ob the object."
  type        = map(object({
    service_account_name = string
    namespace           = string
  }))
}

variable "location" {
  description = "Location where resources should be created"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name that in which the identities will be created"
  type        = string
}

variable "aks_oidc_issuer_url" {
  description = "oidc url that the aks cluster returned. Can be retrieved by azurerm_kubernetes_cluster.aks.oidc_issuer_url"
  type        = string
}

variable "tags" {
  description = "any tags that should be created on the resources"
  type        = map(string)
}