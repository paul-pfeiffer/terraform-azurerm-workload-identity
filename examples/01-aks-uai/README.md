# AKS-Azureworkload-id
This is an example setup that follows the official documentation at https://azure.github.io/azure-workload-identity/docs/introduction.html. 
Just execute terraform apply to try it out.

## Setup
1. Creates a Kubernetes Cluster and a Keyvault
2. Set secrets and permissions
3. Configures service account and deploys the pod
4. Creates user assigned identity and configures federated identity


## Confirm your setup
1. Login to your AKS cluster via kubectl
2. Call `kubectl get pods --all-namespaces`. You should see a pod "quick-start" in "quick-start" namespace
3. Call `kubectl logs -n quick-start quick-start`. 
You should see something simiular to `'I0525 11:42:08.888076       1 main.go:63] "successfully got secret" secret="testvalue"'`
4. Perfect, everything is up and running!