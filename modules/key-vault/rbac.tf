locals {
  flattened_role_assignments = flatten([
    for sp in var.rbacAssignments : [
      for roleName in sp.roleDefinitionNames : {
        principal_id = sp.principalId
        role_name    = roleName
      }
    ]
  ])
}

resource "azurerm_role_assignment" "rbac_assignments" {
  for_each             = { for x in local.flattened_role_assignments : "${x.principal_id}-${x.role_name}" => x }
  scope                = azurerm_key_vault.kv.id
  role_definition_name = each.value.role_name
  principal_id         = each.value.principal_id
}

resource "time_sleep" "kv_rbac_delay" {
  create_duration = "10s"
  triggers = {
    rbac_sha256 = sha256(jsonencode(var.rbacAssignments))
  }
  depends_on = [azurerm_role_assignment.rbac_assignments]
}