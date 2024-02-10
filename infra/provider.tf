# Configure desired versions of terraform, azurerm provider
terraform {
  required_version = ">= 1.1.7"
  required_providers {
    azurerm = {
      version = ">=3.47.0"
      source  = "hashicorp/azurerm"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = ">=1.2.24"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">=1.5.0"
    }
  }
}

# Enable features for azurerm
provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
    api_management {
      purge_soft_delete_on_destroy = true
    }
  }
}

# Access client_id, tenant_id, subscription_id and object_id configuration values
data "azurerm_client_config" "current" {}
