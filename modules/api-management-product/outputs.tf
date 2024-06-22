output "id" {
  description = "The id of the product"
  value       = azurerm_api_management_product.apim_product.id
}

output "displayName" {
  description = "The display name of the product"
  value       = azurerm_api_management_product.apim_product.display_name
}

output "productId" {
  description = "The product id of the product"
  value       = azurerm_api_management_product.apim_product.product_id
}

output "subscriptions" {
  description = "The subscriptions of the product, a map with the display name as the key"
  value = { for sub_name, sub in azurerm_api_management_subscription.apim_product_subscription :
    sub.display_name => {
      id              = sub.id
      subscription_id = sub.subscription_id
    }
  }
}