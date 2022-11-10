resource "azurerm_data_factory_linked_service_key_vault" "linkedKV" {
  name            = "linkedKV"
  data_factory_name = var.dfl_datafactory_name
  resource_group_name = var.dfl_resource_group_name
  key_vault_id    = var.dfl_keyvaultid
}