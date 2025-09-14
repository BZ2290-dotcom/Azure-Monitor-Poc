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

data "azurerm_log_analytics_workspace_shared_keys" "keys" {
  workspace_id = data.azurerm_log_analytics_workspace.existing.id
}

resource "azurerm_virtual_network" "vnet" {
  name                = "poc-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "East US"
  resource_group_name = "poc-monitor-rg"
}

resource "azurerm_subnet" "subnet" {
  name                 = "poc-subnet"
  resource_group_name  = "poc-monitor-rg"
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "nic" {
  name                = "poc-nic"
  location            = "East US"
  resource_group_name = "poc-monitor-rg"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                = "poc-vm"
  resource_group_name = "poc-monitor-rg"
  location            = "East US"
  size                = "Standard_B1s"
  admin_username      = "azureuser"
  admin_password      = "P@ssword1234!"
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

resource "azurerm_virtual_machine_extension" "log_analytics_agent" {
  name                       = "LogAnalyticsAgent"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm.id
  publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
  type                       = "MicrosoftMonitoringAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true

  settings = jsonencode({
    workspaceId = data.azurerm_log_analytics_workspace.existing.workspace_id
  })

  protected_settings = jsonencode({
    workspaceKey = data.azurerm_log_analytics_workspace_shared_keys.keys.primary_shared_key
  })
}
