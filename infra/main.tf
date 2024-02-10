resource "azurecaf_name" "apim_name" {
  resource_type = "azurerm_api_management"
  random_length = 0
  clean_input   = true
  name          = "devex-demo"
}

module "loganalytics" {
  source         = "./core/monitor/loganalytics"
  location       = var.location
  rg_name        = local.rg_name
  tags           = var.tags
  resource_token = "la1"
}

module "appinsights" {
  source           = "./core/monitor/applicationinsights"
  location         = var.location
  rg_name          = local.rg_name
  tags             = var.tags
  workspace_id     = module.loganalytics.LOGANALYTICS_WORKSPACE_ID
  environment_name = var.environment_name
  resource_token   = "ai1"
}

module "apim" {
  source                    = "./core/gateway/apim"
  location                  = var.location
  rg_name                   = local.rg_name
  name                      = azurecaf_name.apim_name.result
  application_insights_name = module.appinsights.APPLICATIONINSIGHTS_NAME
  tags                      = var.tags
}

module "aad" {
  source    = "./core/security/aad"
  apim_name = module.apim.APIM_SERVICE_NAME
}
