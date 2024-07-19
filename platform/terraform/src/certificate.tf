# resource "azurerm_key_vault_certificate" "cert" {
#   name         = "${var.prefix}-cert"
#   key_vault_id = module.keyvault.keyvault.id

#   certificate_policy {
#     issuer_parameters {
#       name = "Self"
#     }

#     key_properties {
#       exportable = true
#       key_size   = 2048
#       key_type   = "RSA"
#       reuse_key  = true
#     }

#     lifetime_action {
#       action {
#         action_type = "AutoRenew"
#       }

#       trigger {
#         days_before_expiry = 30
#       }
#     }

#     secret_properties {
#       content_type = "application/x-pkcs12"
#     }

#     x509_certificate_properties {
#       # Server Authentication = 1.3.6.1.5.5.7.3.1
#       # Client Authentication = 1.3.6.1.5.5.7.3.2
#       extended_key_usage = ["1.3.6.1.5.5.7.3.1","1.3.6.1.5.5.7.3.2"]

#       key_usage = [
#         "cRLSign",
#         "dataEncipherment",
#         "digitalSignature",
#         "keyAgreement",
#         "keyCertSign",
#         "keyEncipherment",
#       ]

#       subject_alternative_names {
#         dns_names = [
#             # local.apim_gateway_dns_name,
#             # local.apim_management_dns_name,
#             # local.apim_devportal_dns_name,
#             # local.apim_scm_dns_name
#         ]
#       }

#       subject            = "CN=${var.root_dns_name}"
#       validity_in_months = 12
#     }
#   }
# }
