resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = "myrg-${random_string.my_random_string.result}"
}

resource "random_string" "my_random_string" {
  length  = 8
  special = false
}