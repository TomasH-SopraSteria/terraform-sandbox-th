resource "azurerm_data_factory_linked_service_key_vault" "example" {
  name            = "linkedKV"
  data_factory_id = var.dfl_keyvaultid
  key_vault_id    = var.dfl_datafactoryid
}