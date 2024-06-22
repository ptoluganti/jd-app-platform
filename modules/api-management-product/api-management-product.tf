resource "azurerm_api_management_product" "apim_product" {
  provider              = azurerm.apim
  product_id            = var.productId
  resource_group_name   = var.apiManagementResourceGroupName
  api_management_name   = var.apiManagementName
  display_name          = var.productDisplayName
  description           = var.productDescription
  subscription_required = var.subscriptionRequired
  published             = true
}

resource "azurerm_api_management_subscription" "apim_product_subscription" {
  for_each = toset(var.subscriptionNames)

  provider            = azurerm.apim
  resource_group_name = var.apiManagementResourceGroupName
  api_management_name = var.apiManagementName
  product_id          = azurerm_api_management_product.apim_product.id
  display_name        = each.value
  state               = "active"

  lifecycle {
    ignore_changes = [
      state,
      allow_tracing
    ]
  }
}

resource "azurerm_api_management_product_policy" "apim_product_policy" {
  count = var.policyXmlContent == null ? 0 : 1

  provider            = azurerm.apim
  product_id          = azurerm_api_management_product.apim_product.product_id
  resource_group_name = var.apiManagementResourceGroupName
  api_management_name = var.apiManagementName

  xml_content = var.policyXmlContent
}