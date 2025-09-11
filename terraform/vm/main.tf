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

