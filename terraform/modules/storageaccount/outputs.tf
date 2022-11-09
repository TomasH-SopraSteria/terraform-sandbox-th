output "sa_id" {
  description = "Id of the storage account created."
  value       = azurerm_storage_account.storageaccount.id
}

output "sa_name" {
  description = "Name of the storage account created."
  value       = azurerm_storage_account.storageaccount.name
}

output "sa_secret" {
  description = "Secret of the storage account created."
  value       = azurerm_storage_account.storageaccount.primary_access_key
}