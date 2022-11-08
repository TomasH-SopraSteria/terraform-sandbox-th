output "id" {
  description = "Id of the storage account created."
  value       = azurerm_data_factory.datafactorysandbox.id
}

output "name" {
  description = "Id of the data factory created."
  value       = azurerm_data_factory.datafactorysandbox.name
}


output "principalid" {
  description = "Id of the data factory created."
  value       = azurerm_data_factory.datafactorysandbox.identity.0.principal_id
}
