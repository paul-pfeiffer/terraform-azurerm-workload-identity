location = "westeurope"
name     = "adwi-test"
tags     = {
  managed-by  = "terraform"
  environment = "sandbox"
}

quick_start_namespace = "quick-start"

identities          = {
  quick-start-sa = {
    namespace = "quick-start"
  }
}