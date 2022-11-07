resource "azurerm_data_factory" "datafactorysandbox" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group
}