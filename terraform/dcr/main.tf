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

resource "azurerm_monitor_data_collection_rule" "dcr" {
  name                = "poc-dcr"
  location            = "East US"
  resource_group_name = "poc-monitor-rg"

  data_flow {
    streams      = ["Microsoft-Perf"]
    destinations = ["log_analytics"]
  }

  destinations {
    log_analytics {
      name               = "log_analytics"
      workspace_resource_id = data.azurerm_log_analytics_workspace.existing.id
    }
  }

  data_sources {
    performance_counter {
      name = "perf-cpu"
      streams = ["Microsoft-Perf"]
      sampling_frequency_in_seconds = 60
      counter_specifiers = [
        "\\Processor(_Total)\\% Processor Time"
      ]
    }
  }
}
