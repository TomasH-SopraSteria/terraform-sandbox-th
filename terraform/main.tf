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

# module "keyvault" {
#   source = "./modules/keyvault"
#   name = "kv-sandbox"
#   location = var.location
#   resource_group_name = var.rg_name
# }

module "datafactory" {
  source = "./modules/datafactory"
  df_name = "df-sandbox-tomash"
  df_location = "${var.location}"
  df_resource_group_name = "${var.rg_name}"
}

module "storageaccount" {
  source = "./modules/storageaccount"
  #The field can contain only lowercase letters and numbers. Name must be between 3 and 24 characters.
  sa_name = "sasandboxth1"
  sa_location = "${var.location}"
  sa_resource_group_name = "${var.rg_name}"
  sa_account_tier = "Standard"
  sa_account_replication_type = "GRS"
}