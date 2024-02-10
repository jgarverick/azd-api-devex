terraform {
  required_version = ">= 1.1.7, < 2.0.0"
  required_providers {
    azurerm = {
      version = "~>3.47.0"
      source  = "hashicorp/azurerm"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "~>1.2.24"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~>1.5.0"
    }
  }
}

resource "azuread_application" "name" {
  display_name            = "apim-devex-demo-auth"
  sign_in_audience        = "AzureADMyOrg"
  group_membership_claims = ["All"]
}

resource "azuread_application_password" "name" {
  application_id = azuread_application.name.application_id
}

resource "azuread_application_redirect_uris" "name" {
  application_id = azuread_application.name.application_id
  redirect_uris = ["https://${var.apim_name}.developer.azure-api.net/signin",
    "https://${var.apim_name}.developer.azure-api.net",
    "https://authorization-manager.consent.azure-apim.net/redirect/apim/${var.apim_name}",
  "https://${var.apim_name}.azure-api.net/.auth/login/aad/callback"]
  type = "SPA"
}
