resource "azurerm_dashboard" "monitor_dashboard" {
  name                = "poc-monitor-dashboard"
  resource_group_name = "poc-monitor-rg"
  location            = "East US"
  tags                = {
    environment = "POC"
  }

  dashboard_properties = jsonencode({
    lenses = {
      "0" = {
        order = 0
        parts = {
          "0" = {
            position = {
              x = 0
              y = 0
              rowSpan = 2
              colSpan = 3
            }
            metadata = {
              type = "Extension/HubsExtension/PartType/MarkdownPart"
              settings = {
                content = "## Azure Monitor POC Dashboard"
              }
            }
          }
        }
      }
    }
  })
}
