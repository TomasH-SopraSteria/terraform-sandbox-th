resource "azurerm_resource_group" "rg_sandbox-th" {
    name = "${var.rg_name}"
    location = "${var.location}"
}

data "azurerm_client_config" "current" {}

module "storageaccount" {
  source = "./modules/storageaccount"
  #The field can contain only lowercase letters and numbers. Name must be between 3 and 24 characters.
  sa_name = "sasandboxth5${var.environment}"
  sa_location = "${var.location}"
  sa_resource_group_name = "${var.rg_name}"
  sa_account_tier = "Standard"
  sa_account_replication_type = "GRS"
  sa_account_kind = "StorageV2"
  sa_is_hns_enabled = "true"
}

module "datalake" {
  source = "./modules/storageaccount/sadatalake"
  dl_name = "datalake-sandbox-1${var.environment}"
  dl_storageaccid = module.storageaccount.sa_id
  dl_properties = "aGVsbG8="
}

module "datafactory" {
  source = "./modules/datafactory"
  df_name = "df-sandbox-tomash${var.environment}"
  df_location = "${var.location}"
  df_resource_group_name = "${var.rg_name}"
  df_identity = "SystemAssigned"
}

# module "databricks" {
#   source = "./modules/databricks"
#   db_name = "db-sandbox-tomas${var.environment}"
#   db_location = "${var.location}"
#   db_resource_group_name = "${var.rg_name}"
#   db_sku = "standard"
#   db_tag_environment = "${var.environment}"
#   db_connector_name = "connector1"
#   db_identity = "SystemAssigned"
# }

module "keyvault" {
  source = "./modules/keyvault"
  kv_name = "kv-sandbox-tomash3${var.environment}"
  kv_location = "${var.location}"
  kv_resource_group_name = "${var.rg_name}"
  kv_enabled_for_disk_encryption = true
  kv_tenant_id = data.azurerm_client_config.current.tenant_id
  kv_soft_delete_retention_days = 7
  kv_purge_protection_enabled = false
  kv_object_id = data.azurerm_client_config.current.object_id
  kv_sku_name = "standard"
  kv_secret_sa_name = "secretsa3"
  kv_secret_sa_value = module.storageaccount.sa_secret
  kv_adfaccess = module.datafactory.df_principalid
}

module "datafactorylinkedservices" {
  source = "./modules/datafactory/dflinkedkv"
  dfl_resource_group_name = "${var.rg_name}"
  dfl_datafactory_name = module.datafactory.df_name
  dfl_keyvaultid = module.keyvault.kv_id
  dfl_datafactoryid = module.datafactory.df_id
}