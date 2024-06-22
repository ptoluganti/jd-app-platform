locals {
  asset_path            = var.assetBasePath
  apm_id                = var.apmId
  name                  = var.name
  api_environment       = var.apiEnvironment
  product               = local.apm_id
  product_lower         = lower(local.product)
  product_upper         = upper(local.product)
  service               = var.name
  service_lower         = lower(local.service)
  backend_id            = lower(local.backend_title)
  backend_title         = "${local.product}-${local.service}-Backend"
  backend_description   = replace(local.backend_title, "-", " ")
  backend_url           = "https://${var.customDomainHost}.${var.customDomainPrivateDnsZoneName}"
  api_path              = var.apiPath != "" ? var.apiPath : "${local.service_lower}${var.apiPathSuffix}"
  api_name              = "${local.product_lower}-${local.service_lower}-api"
  api_display_name      = "${local.api_base_display_name} API"
  api_base_name         = "${local.product_lower}-${local.service_lower}"
  api_base_display_name = "${local.product_upper} ${local.service} Service"
  policy_xml_content    = templatefile(var.policyTemplateFile, { backend_id = local.backend_id, additional_params = var.additionalPolicyParameters })

  flattened_product_apis = flatten([
    for av in var.versions : [
      for id in var.apimProductIds : {
        api_name   = "${local.api_name}_${av.version}"
        product_id = id
      }
    ]
  ])
}