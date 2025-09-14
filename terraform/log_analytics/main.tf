provider "azurerm" {
  features {}

  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

resource "azurerm_log_analytics_workspace" "workspace" {
  name                = "poc-law"
  location            = "East US"
  resource_group_name = "poc-monitor-rg"  # Reference existing RG
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

output "workspace_id" {
  value = azurerm_log_analytics_workspace.workspace.id
}
