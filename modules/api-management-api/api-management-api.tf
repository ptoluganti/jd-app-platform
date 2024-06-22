resource "azurerm_api_management_backend" "backend" {
  provider            = azurerm.apim
  name                = local.backend_id
  title               = local.backend_title
  description         = local.backend_description
  resource_group_name = var.apiManagement.resourceGroupName
  api_management_name = var.apiManagement.name
  protocol            = "http"
  url                 = local.backend_url
  tls {
    validate_certificate_chain = var.validateCertificateChain
    validate_certificate_name  = var.validateCertificateName
  }
}

resource "azurerm_api_management_api_version_set" "version_set" {
  provider            = azurerm.apim
  name                = "${local.api_name}-versionset"
  resource_group_name = var.apiManagement.resourceGroupName
  api_management_name = var.apiManagement.name
  display_name        = local.api_display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "api" {
  for_each = { for api in var.versions : api.version => api }

  provider              = azurerm.apim
  name                  = "${local.api_name}_${each.value.version}"
  resource_group_name   = var.apiManagement.resourceGroupName
  api_management_name   = var.apiManagement.name
  display_name          = local.api_display_name
  path                  = local.api_path
  protocols             = ["https"]
  api_type              = "http"
  revision              = "1"
  subscription_required = true
  version_set_id        = resource.azurerm_api_management_api_version_set.version_set.id
  version               = each.value.version
  import {
    content_value  = each.value.specContent
    content_format = each.value.specFormat
  }

  depends_on = [
    resource.azurerm_api_management_api_version_set.version_set
  ]
}

resource "azurerm_api_management_api_policy" "api_policy" {
  for_each = { for api in var.versions : api.version => api }

  provider            = azurerm.apim
  api_name            = "${local.api_name}_${each.value.version}"
  resource_group_name = var.apiManagement.resourceGroupName
  api_management_name = var.apiManagement.name
  xml_content         = local.policy_xml_content
  depends_on = [
    resource.azurerm_api_management_api.api,
    resource.azurerm_api_management_backend.backend
  ]
}

resource "azurerm_api_management_product_api" "product_api" {
  for_each = { for api in local.flattened_product_apis : "${api.api_name}_${api.product_id}" => api }

  provider            = azurerm.apim
  api_name            = each.value.api_name
  product_id          = each.value.product_id
  resource_group_name = var.apiManagement.resourceGroupName
  api_management_name = var.apiManagement.name
  depends_on = [
    resource.azurerm_api_management_api.api
  ]
}

resource "azurerm_api_management_api_diagnostic" "api_logs" {
  for_each = { for api in var.versions : api.version => api }

  provider                 = azurerm.apim
  identifier               = "applicationinsights"
  resource_group_name      = var.apiManagement.resourceGroupName
  api_management_name      = var.apiManagement.name
  api_name                 = "${local.api_name}_${each.value.version}"
  api_management_logger_id = var.apiManagement.loggerId

  sampling_percentage       = 100.0
  always_log_errors         = true
  log_client_ip             = true
  verbosity                 = "information"
  http_correlation_protocol = "W3C"
  depends_on = [
    resource.azurerm_api_management_api.api
  ]
}