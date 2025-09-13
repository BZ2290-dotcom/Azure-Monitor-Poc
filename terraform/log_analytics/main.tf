provider "azurerm" {
  features {}

  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}


resource "azurerm_resource_group" "rg" {
  name     = "poc-monitor-rg"
  location = "East US"
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = "poc-law"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}
