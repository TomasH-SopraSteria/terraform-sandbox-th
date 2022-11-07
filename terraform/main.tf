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

# module "setup_keyvault" {
#   source = "./modules/keyvault"
#   kv_name = "kv_sandbox"
#   kv_location = var.location
#   kv_resource_group = var.rg_name
  
# }

module "datafactory" {
  source = "./modules/datafactory"
  name = "df-sandbox-tomash"
  location = "${var.location}"
  resource_group_name = "${var.rg_name}"
}