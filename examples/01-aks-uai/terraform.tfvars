location = "westeurope"
tags     = {
  managed-by  = "terraform"
  environment = "sandbox"
}

identities = {
  quick-start = {
    service_account_name = "quick-start-sa"
    namespace            = "quick-start"
  }
}