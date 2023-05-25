resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = var.name
}

resource "random_string" "my_random_string" {
  length  = 8
  special = false
}