resource "azurerm_key_vault" "keyvaultsandbox" {
  name                        = var.kv_name
  location                    = var.kv_location
  resource_group_name         = var.kv_resource_group_name
  enabled_for_disk_encryption = var.kv_enabled_for_disk_encryption
  tenant_id                   = var.kv_tenant_id
  soft_delete_retention_days  = var.kv_soft_delete_retention_days
  purge_protection_enabled    = var.kv_purge_protection_enabled

  sku_name = var.kv_sku_name

  access_policy {
    tenant_id = var.kv_tenant_id
    object_id = var.kv_object_id

    key_permissions = [
      "get",
    ]

    secret_permissions = [
      "get",
      "list",
      "set",
      "delete"
    ]

    storage_permissions = [
      "get",
    ]
  }
}