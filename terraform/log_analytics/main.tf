provider "azurerm" {
  features {}

  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

data "azurerm_log_analytics_workspace" "existing" {
  name                = "poc-law"
  resource_group_name = "poc-monitor-rg"
}

output "workspace_id" {
  value = data.azurerm_log_analytics_workspace.existing.id
}
