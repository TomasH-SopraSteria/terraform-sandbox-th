resource "azurerm_storage_data_lake_gen2_filesystem" "datalake" {
  name               = sadl_name1
  storage_account_id = sadl_storageaccid1

    properties = {
    hello = sadl_properties1
  }

# Access Permission ACL for Container/Root Directory
    ace {
    # no id => owning user (i.e. deployment account)
    permissions = "rwx"
    scope       = "access"
    type        = "user"
  }
}

