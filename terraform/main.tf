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
  sa_name = "sasandboxth2"
  sa_location = "${var.location}"
  sa_resource_group_name = "${var.rg_name}"
  sa_account_tier = "Standard"
  sa_account_replication_type = "GRS"
  sa_account_kind = "StorageV2"
  sa_is_hns_enabled = "true"
}

module "datafactory" {
  source = "./modules/datafactory"
  df_name = "df-sandbox-tomash"
  df_location = "${var.location}"
  df_resource_group_name = "${var.rg_name}"
}

module "keyvault" {
  source = "./modules/keyvault"
  kv_name = "kv-sandbox-tomash"
  kv_location = "${var.location}"
  kv_resource_group_name = "${var.rg_name}"
  kv_enabled_for_disk_encryption = true
  kv_tenant_id = data.azurerm_client_config.current.tenant_id
  kv_soft_delete_retention_days = 7
  kv_purge_protection_enabled = false
  kv_object_id = data.azurerm_client_config.current.object_id
  kv_sku_name = "standard"
  kv_secret_sa_name = "secretsa2"
  kv_secret_sa_value = module.storageaccount.secret
  kv_adfaccess = module.datafactory.principalid
}

module "datafactorylinkedservices" {
  source = "./modules/datafactory/datafactorylinkedservices"
  dfl_resource_group_name = "${var.rg_name}"
  dfl_datafactory_name = module.datafactory.name
  dfl_keyvaultid = module.keyvault.id
  dfl_datafactoryid = module.datafactory.id
}