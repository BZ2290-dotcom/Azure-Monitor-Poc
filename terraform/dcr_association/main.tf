resource "azurerm_monitor_data_collection_rule_association" "vm_dcr_association" {
  name                        = "poc-dcr-association"
  target_resource_id          = azurerm_windows_virtual_machine.vm.id
  data_collection_rule_id     = azurerm_monitor_data_collection_rule.dcr.id
  description                 = "Associates VM with DCR for performance monitoring"
}
