output "id" {
  description = "Id of the storage account created."
  value       = azurerm_storage_account.storageaccount.id
}

output "name" {
  description = "Name of the storage account created."
  value       = azurerm_storage_account.storageaccount.name
}

output "secret" {
  description = "Secret of the storage account created."
  value       = azurerm_storage_account.storageaccount.primary_access_key
}