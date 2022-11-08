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

  access_policy {
    tenant_id = "85173d93-99ef-4dff-9b45-495719659133"
    object_id = "8cc37df6-d9d6-4e99-bbd5-b025d5d59a26"

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

  access_policy {
    tenant_id = var.kv_tenant_id
    object_id = var.kv_adfaccess

    key_permissions = [
      "get", 
      "list", 
      "update", 
      "delete"
    ]

    secret_permissions = [
      "get",
      "list"
    ]
  }

}

resource "azurerm_key_vault_secret" "secretsa" {
  name         = var.kv_secret_sa_name
  value        = var.kv_secret_sa_value
  key_vault_id = azurerm_key_vault.keyvaultsandbox.id
}

# resource "azurerm_key_vault_access_policy" "adfaccess" {
#   key_vault_id = azurerm_key_vault.keyvaultsandbox.id
#   tenant_id    = var.kv_tenant_id
#   object_id    = var.kv_adfaccess

#   key_permissions = [
#     "get", "list", "update", "delete",
#   ]
#   secret_permissions = [
#      "get", "list"
#   ]
#   lifecycle {
#     prevent_destroy  = true
#   }

# }