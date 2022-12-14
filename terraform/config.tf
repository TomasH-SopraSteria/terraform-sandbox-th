terraform {
  backend "azurerm" {
    resource_group_name  = "terraformdevops"
    storage_account_name = "tfstorageaccthsandbox"
    container_name       = "terraformstatefiledev"
    key                  = "terraform.tfstate"
  }
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.46.0"
    }
    databricks = {
      source  = "databrickslabs/databricks"
      version = "~> 0.5"
    }
  }
}

provider "azurerm" {
  features {

  }
}

provider "databricks" {}
