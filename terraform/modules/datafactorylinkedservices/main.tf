resource "azurerm_data_factory_linked_service_key_vault" "linkedKV" {
  name            = "linkedKV"
  data_factory_name = var.data_factory_name
  resource_group_name = var.dfl_resource_group_name
  data_factory_id = var.dfl_keyvaultid
  key_vault_id    = var.dfl_datafactoryid
}