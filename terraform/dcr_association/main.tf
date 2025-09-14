provider "azurerm" {
  features {}

  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

data "azurerm_monitor_data_collection_rule" "dcr" {
  name                = "poc-dcr"
  resource_group_name = "poc-monitor-rg"
}

data "azurerm_windows_virtual_machine" "vm" {
  name                = "poc-vm"
  resource_group_name = "poc-monitor-rg"
}

resource "azurerm_monitor_data_collection_rule_association" "vm_dcr_association" {
  name                        = "poc-dcr-association"
  target_resource_id          = data.azurerm_windows_virtual_machine.vm.id
  data_collection_rule_id     = data.azurerm_monitor_data_collection_rule.dcr.id
  description                 = "Associates VM with DCR for performance monitoring"
}
