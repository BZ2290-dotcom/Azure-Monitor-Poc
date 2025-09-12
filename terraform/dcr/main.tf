resource "azurerm_monitor_data_collection_rule" "dcr" {
  name                = "poc-dcr"
  location            = "East US"
  resource_group_name = "poc-monitor-rg"

  data_flow {
    streams      = ["Microsoft-InsightsMetrics"]
    destinations = ["logAnalyticsDestination"]
  }

  destinations {
    log_analytics {
      name                  = "logAnalyticsDestination"
      workspace_resource_id = "/subscriptions/e82f8c84-0b4f-4914-b3fb-44663a8edb99/resourceGroups/poc-monitor-rg/providers/Microsoft.OperationalInsights/workspaces/poc-law"
    }
  }

  data_sources {
    performance_counter {
      name           = "perfCounterSource"
      streams        = ["Microsoft-InsightsMetrics"]
      sampling_frequency_in_seconds = 60
      counter_specifiers = [
        "\\Processor(_Total)\\% Processor Time",
        "\\Memory\\Available MBytes"
      ]
    }
  }

  description = "POC DCR for collecting performance metrics"
}
