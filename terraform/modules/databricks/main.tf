resource "azurerm_databricks_workspace" "databricks" {
  name                = var.db_name
  resource_group_name = var.db_resource_group_name
  location            = var.db_location
  sku                 = var.db_sku

  tags = {
    Environment = var.db_tag_environment
  }
}

# resource "azurerm_databricks_access_connector" "dbconnector" {
#   name                = db_connector_name
#   resource_group_name = azurerm_resource_group.example.name
#   location            = azurerm_resource_group.example.location

#     identity {
#       type = var.db_identity
#     }

#     tags = {
#       Environment = var.db_tag_environment
#     }
# }

data "databricks_node_type" "smallest" {
  depends_on = [
    azurerm_databricks_workspace.databricks
  ]
  local_disk = true
}

data "databricks_spark_version" "latest_lts" {
  depends_on = [
    azurerm_databricks_workspace.databricks
  ]
  long_term_support = true
}

resource "databricks_instance_pool" "pool" {
  instance_pool_name  = "CodeRedPool"
  min_idle_instances = 0
  max_capacity = 2
  node_type_id = data.databricks_node_type.smallest.id

  idle_instance_autotermination_minutes = 10
}

resource "databricks_cluster" "shared_autoscaling" {
  depends_on = [
    azurerm_databricks_workspace.databricks
  ]
  instance_pool_id = databricks_instance_pool.pool.id
  cluster_name            = "Shared Autoscaling"
  spark_version           = data.databricks_spark_version.latest_lts.id
  node_type_id            = data.databricks_node_type.smallest.id
  autotermination_minutes = 20
  autoscale {
    min_workers = 1
    max_workers = 2
  }
  spark_conf = {
    "spark.databricks.io.cache.enabled" : true
  }
  custom_tags = {
    "createdby" = "InfraTeam"
  }
}