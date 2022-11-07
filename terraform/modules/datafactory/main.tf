resource "azurerm_data_factory" "datafactorysandbox" {
  name                = var.df_name
  location            = var.df_location
  resource_group_name = var.df_resource_group
}