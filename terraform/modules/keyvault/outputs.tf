output "kv_id" {
  description = "Id of the keyvault"
  value       = azurerm_key_vault_secret.keyvaultsandbox.id
}

output "kv_secret_sa" {
  description = "Name of secret to sa"
  value       = azurerm_key_vault_secret.secretsa.name
}
