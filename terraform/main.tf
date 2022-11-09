terraform {
  backend "azurerm" {
    resource_group_name  = "terraformdevops"
    storage_account_name = "tfstorageaccthsandbox"
    container_name       = "terraformstatefile"
    key                  = "terraform.tfstate"
  }
}

resource "azurerm_resource_group" "rg_sandbox-th" {
    name = var.rg_name
    location = var.location
}

data "azurerm_client_config" "current" {}

module "storageaccount" {
  source = "./modules/storageaccount"
  #The field can contain only lowercase letters and numbers. Name must be between 3 and 24 characters.
  sa_name = "sasandboxth5"
  sa_location = "${var.location}"
  sa_resource_group_name = "${var.rg_name}"
  sa_account_tier = "Standard"
  sa_account_replication_type = "GRS"
  sa_account_kind = "StorageV2"
  sa_is_hns_enabled = "true"
}

module "datalake" {
  source = "./modules/datalake"
  sadl_name = "datalake-sandbox-th5"
  sadl_storageaccid = module.storageaccount.sa_id
  sadl_properties = "aGVsbG8="
}

# module "storageaccount2" {
#   source = "./modules/storageaccount"
#   #The field can contain only lowercase letters and numbers. Name must be between 3 and 24 characters.
#   sa_name = "sasandboxt6"
#   sa_location = "${var.location}"
#   sa_resource_group_name = "${var.rg_name}"
#   sa_account_tier = "Standard"
#   sa_account_replication_type = "GRS"
#   sa_account_kind = "BlobStorage"
#   sa_is_hns_enabled = "false"
# }

module "datafactory" {
  source = "./modules/datafactory"
  df_name = "df-sandbox-tomash"
  df_location = "${var.location}"
  df_resource_group_name = "${var.rg_name}"
}

module "keyvault" {
  source = "./modules/keyvault"
  kv_name = "kv-sandbox-tomash3"
  kv_location = "${var.location}"
  kv_resource_group_name = "${var.rg_name}"
  kv_enabled_for_disk_encryption = true
  kv_tenant_id = data.azurerm_client_config.current.tenant_id
  kv_soft_delete_retention_days = 7
  kv_purge_protection_enabled = false
  kv_object_id = data.azurerm_client_config.current.object_id
  kv_sku_name = "standard"
  kv_secret_sa_name = "secretsa3"
  kv_secret_sa_value = module.storageaccount11.sa_secret
  kv_adfaccess = module.datafactory.df_principalid
}

module "datafactorylinkedservices" {
  source = "./modules/datafactorylinkedservices"
  dfl_resource_group_name = "${var.rg_name}"
  dfl_datafactory_name = module.datafactory.df_name
  dfl_keyvaultid = module.keyvault.kv_id
  dfl_datafactoryid = module.datafactory.df_id
}