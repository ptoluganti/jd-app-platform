resource "azurerm_api_management_logger" "app_insights" {
  provider            = azurerm.apim
  name                = "${var.apmId}-${var.environmentAcronym}-app-insights"
  api_management_name = var.apiManagementName
  resource_group_name = var.apiManagementResourceGroupName

  application_insights {
    instrumentation_key = var.applicationInsightsInstrumentationKey
  }
}