resource "azurerm_data_factory_linked_service_key_vault" "linkedKV" {
  name            = "linkedKV"
  data_factory_name = var.dfl_datafactory_name
  resource_group_name = var.dfl_resource_group_name
  key_vault_id    = var.dfl_keyvaultid
}

resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "linkedSA" {
  name                  = "linkedSA"
  data_factory_name     = var.dfl_datafactory_name
  storage_account_key   = var.dfl_storage_acc_secret
  url                   = "https://${var.dfl_storage_acc_name}.dfs.core.windows.net"
}