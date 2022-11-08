resource "azurerm_storage_account" "storageaccount" {
  name                     = var.sa_name
  resource_group_name      = var.sa_resource_group_name
  location                 = var.sa_location
  account_tier             = var.sa_account_tier
  account_replication_type = var.sa_account_replication_type

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_data_lake_gen2_filesystem" "datalake" {
  name               = "datalake-sandbox-th"
  storage_account_id = azurerm_storage_account.storageaccount.id
}

