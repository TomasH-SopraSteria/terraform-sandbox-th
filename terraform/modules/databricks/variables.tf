variable db_name {
    type = string
    description = "DF name"
}

variable db_location {
    type = string
}

variable db_resource_group_name {
    type = string
    description = "Resource group name"
}

variable db_sku {
    type = string
}

variable db_tag_environment {
    type = string
}

variable db_connector_name {
    type = string
    description = "DF access name"
}

variable db_identity {
    type = string
}