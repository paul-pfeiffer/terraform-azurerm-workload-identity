# create all namespaces that got requested
resource "kubernetes_namespace" "namespace" {
  for_each = local.namespaces
  metadata {
    name = each.key
  }
}

locals {
  namespaces           = toset(values(var.identities).*.namespace)
  quick_start_service_account_name = var.identities["quick-start"].service_account_name
  quick_start_namespace = var.identities["quick-start"].namespace
}

output "namespaces" {
  value = local.namespaces
}

# create the offical test pod
resource "kubernetes_pod_v1" "quick_start_pod" {
  metadata {
    name      = "quick-start"
    namespace = local.quick_start_namespace
    labels    = {
      "azure.workload.identity/use" = "true"
    }
  }

  spec {
    service_account_name = local.quick_start_service_account_name
    container {
      name  = "oidc"
      image = "ghcr.io/azure/azure-workload-identity/msal-go"
      env {
        name  = "KEYVAULT_URL"
        value = azurerm_key_vault.quick-start-keyvault.vault_uri
      }
      env {
        name  = "SECRET_NAME"
        value = azurerm_key_vault_secret.quick-start-secret.name
      }
    }
  }
  depends_on = [
    azurerm_role_assignment.allow_keyvault_for_uai, kubernetes_service_account_v1.quick_start_serviceaccount
  ]
}

# create the service account that will be used for the pod
resource "kubernetes_service_account_v1" "quick_start_serviceaccount" {
  metadata {
    annotations = {
      "azure.workload.identity/client-id" = module.awid.identities["quick-start"].client_id
    }
    name      = local.quick_start_service_account_name
    namespace = local.quick_start_namespace
  }
}

data "azurerm_subscription" "current" {}
data "azurerm_client_config" "current" {}

# create a testing keyvault. the pod will access this keyvault and try to get a secret
resource "azurerm_key_vault" "quick-start-keyvault" {
  location                  = var.location
  name                      = "mykv-${random_string.my_random_string.result}"
  resource_group_name       = azurerm_resource_group.rg.name
  sku_name                  = "standard"
  tenant_id                 = data.azurerm_subscription.current.tenant_id
  enable_rbac_authorization = true
}


# set permission for the logged in account and create a secret that will be read by the pod
resource "azurerm_role_assignment" "allow_keyvault" {
  principal_id         = data.azurerm_client_config.current.object_id
  role_definition_name = "Key Vault Secrets Officer"
  scope                = azurerm_key_vault.quick-start-keyvault.id
}

resource "azurerm_key_vault_secret" "quick-start-secret" {
  key_vault_id = azurerm_key_vault.quick-start-keyvault.id
  name         = "mysecret"
  value        = "testvalue"
  depends_on   = [azurerm_role_assignment.allow_keyvault]
}

# set permission for user assigned identity and create secret
resource "azurerm_role_assignment" "allow_keyvault_for_uai" {
  principal_id         = module.awid.identities["quick-start"].principal_id
  role_definition_name = "Key Vault Secrets User"
  scope                = azurerm_key_vault.quick-start-keyvault.id
}

