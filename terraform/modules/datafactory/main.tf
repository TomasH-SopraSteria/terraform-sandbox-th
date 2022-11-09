resource "azurerm_data_factory" "datafactorysandbox" {
    name                = "${var.df_name}"
    resource_group_name = "${var.df_resource_group_name}"
    location            = "${var.df_location}"

    identity {
        type = "SystemAssigned"
    }

    github_configuration {
      account_name = "TomasH-SopraSteria"
      branch_name = "main"
      git_url = "https://github.com/TomasH-SopraSteria/terraform-sandbox-df"
      repository_name = "terraform-sandbox-df"
      root_folder = "/"
    }

}
