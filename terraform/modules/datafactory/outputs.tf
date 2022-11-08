output "principalid" {
  description = "Id of the data factory created."
  value       = azurerm_data_factory.datafactorysandbox.identity.0.principal_id
}
