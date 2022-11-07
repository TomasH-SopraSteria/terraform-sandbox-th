resource "azurerm_data_factory" "datafactorysandbox" {
    name                = "${var.name}"
    resource_group_name = "${var.resource_group_name}"
    location            = "${var.location}"
}