resource "azurerm_container_app_environment" "ace" {
  name                               = "${var.prefix}-Environment-01"
  location                           = var.location
  resource_group_name                = var.resource_group_name
  infrastructure_subnet_id           = try(var.infrastructure_subnet_id, null)
  infrastructure_resource_group_name = try(var.infrastructure_resource_group_name, null)
  internal_load_balancer_enabled     = try(var.internal_load_balancer_enabled, null)
  zone_redundancy_enabled            = try(var.zone_redundancy_enabled, null)
  log_analytics_workspace_id         = try(var.log_analytics_workspace_id, null)
  dynamic "workload_profile" {
    for_each = try(var.workload_profile, {})
    content {
      name                  = workload_profile.value.name
      workload_profile_type = workload_profile.value.workload_profile_type
      maximum_count         = workload_profile.value.maximum_count
      minimum_count         = workload_profile.value.minimum_count
    }
  }
}
