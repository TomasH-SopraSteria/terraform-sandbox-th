resource "azurerm_storage_data_lake_gen2_filesystem" "datalake" {
  name               = dl_name
  storage_account_id = dl_storageacc

    properties = {
    hello = dl_properties
  }

# Access Permission ACL for Container/Root Directory
    ace {
    # no id => owning user (i.e. deployment account)
    permissions = "rwx"
    scope       = "access"
    type        = "user"
  }
}