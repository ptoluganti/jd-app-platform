variable "apiManagementResourceGroupName" {
  type        = string
  description = "The name of the resource group containing API Management"
}

variable "apiManagementName" {
  type        = string
  description = "The name of the API Management instance"
}

variable "applicationInsightsInstrumentationKey" {
  type        = string
  description = "The instrumentation key of Application Insights"
}

variable "apmId" {
  type        = string
  description = "The APM Id"
}

variable "environmentAcronym" {
  type        = string
  description = "The environment acronym for the logger"
}