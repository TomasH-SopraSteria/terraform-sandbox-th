resource "azurerm_storage_account" "storageaccount" {
  name                     = var.sa_name
  resource_group_name      = var.sa_resource_group_name
  location                 = var.sa_location
  account_tier             = var.sa_account_tier
  account_replication_type = var.sa_account_replication_type 
  account_kind             = var.sa_account_kind
  is_hns_enabled           = var.sa_is_hns_enabled

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_data_lake_gen2_filesystem" "datalake" {
  name               = "datalake-sandbox-th"
  storage_account_id = azurerm_storage_account.storageaccount.id

    properties = {
    hello = "aGVsbG8="
  }

# Access Permission ACL for Container/Root Directory
    ace {
    # no id => owning user (i.e. deployment account)
    permissions = "rwx"
    scope       = "access"
    type        = "user"
  }
}

