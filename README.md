# AKS-azure-workload-id
Azure Kubernetes Cluster Azure workload Identity integration

User Assigned Managed Identity integration of AzureAD Workload Identity
Learn more at https://azure.github.io/azure-workload-identity/docs/introduction.html

This module is published in the Terraform Module Registry https://registry.terraform.io/modules/paul-pfeiffer/workload-identity/azurerm/latest

## Usage
```hcl
module "azure_workload_identity" {
  source = "paul-pfeiffer/azureworkloadidentity/azurerm"

  aks_oidc_issuer_url = azurerm_kubernetes_cluster.aks.oidc_issuer_url
  location            = "westeurope"
  resource_group_name = "mytestrg"

  identities = {
    "quick-start" = {
      service_account_name = "quick-start-service-account" # kubernetes service account name
      namespace           = "quick-start"                  # kubernetes namespace
    }
  }

  tags = {
    managed-by = "terraform"
    workload   = "aks"
  }
}
```

## Usecases
This module sets creates user assigned identities and configures federated identity credentials so that it will work with azure workload identity.

