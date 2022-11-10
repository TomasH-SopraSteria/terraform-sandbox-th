resource "azurerm_databricks_workspace" "databricks" {
  name                = var.db_name
  resource_group_name = var.db_resource_group_name
  location            = var.db_location
  sku                 = var.db_sku

  tags = {
    Environment = var.db_tag_environment
  }
}

resource "azurerm_databricks_access_connector" "example" {
  name                = "databrickstest"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}