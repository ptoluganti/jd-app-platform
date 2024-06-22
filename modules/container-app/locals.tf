locals {
  acr_repo_name = var.environmentAcronym == "prod" ? "ida" : "ida-${var.environmentAcronym}"

  apim_02_ingress_rules = try(var.apiManagement02SubnetCidr == null ? [] : [
    {
      name             = "Allow-APIManagement_02"
      ip_address_range = "${var.apiManagement02SubnetCidr}"
    }
  ], [])

  default_ingress_rules = [
    {
      name             = "Allow-APIManagement"
      ip_address_range = "${var.apiManagementSubnetCidr}"
    },
    {
      name             = "Allow-ContainerAppEnvironment"
      ip_address_range = "${var.containerAppEnvironment.subnetCidr}"
    }
  ]
  additional_ingress_rules = [
    for name, ip_address_range in var.additionalAllowedIpRules :
    {
      name             = name
      ip_address_range = ip_address_range
    }
  ]
  allowed_ingress_rules = flatten([local.default_ingress_rules, local.additional_ingress_rules, local.apim_02_ingress_rules])
}
