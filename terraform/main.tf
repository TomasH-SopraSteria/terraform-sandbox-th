# Create a resource group
resource "azurerm_resource_group" "rg_sandbox-th" {
    name = var.rg_name
    location = var.location
}