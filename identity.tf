resource "azurerm_user_assigned_identity" "uai" {
  for_each            = var.identities
  location            = var.location
  resource_group_name = var.resource_group_name
  name                = each.value.service_account_name
  tags                = var.tags
}

## Azure AD federated identity used to federate kubernetes with Azure AD
resource "azurerm_federated_identity_credential" "app" {
  for_each            = var.identities
  name                = azurerm_user_assigned_identity.uai[each.key].name
  resource_group_name = azurerm_user_assigned_identity.uai[each.key].resource_group_name
  parent_id           = azurerm_user_assigned_identity.uai[each.key].id
  audience            = ["api://AzureADTokenExchange"]
  issuer              = var.aks_oidc_issuer_url
  subject             = "system:serviceaccount:${each.value.namespace}:${azurerm_user_assigned_identity.uai[each.key].name}"
}
