locals {
  aks-cluster-name = "mycluster-${random_string.my_random_string.result}"
}

resource "azurerm_kubernetes_cluster" "aks" {
  location            = "westeurope"
  name                = local.aks-cluster-name
  resource_group_name = azurerm_resource_group.rg.name

  # this one is required for azuread workload identity
  oidc_issuer_enabled = true

  # installs the azuread workload identity helm chart
  workload_identity_enabled = true

  identity {
    type = "SystemAssigned"
  }

  dns_prefix = local.aks-cluster-name

  default_node_pool {
    name       = "default"
    vm_size    = "Standard_D2_v3"
    node_count = 1
  }
}

module "awid" {
  source = "../../"

  aks_oidc_issuer_url = azurerm_kubernetes_cluster.aks.oidc_issuer_url
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  identities = var.identities

  tags = var.tags
}