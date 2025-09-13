resource "azurerm_monitor_action_group" "logicapp_action_group" {
  name                = "poc-action-group"
  resource_group_name = "poc-monitor-rg"
  short_name          = "POCAG"
  location            = "Global"

  webhook_receiver {
    name                    = "LogicAppWebhook"
    service_uri             = "https://<your-logic-app-trigger-url>"
    use_common_alert_schema = true
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "cpu_alert" {
  name                = "poc-cpu-alert"
  location            = "East US"
  resource_group_name = "poc-monitor-rg"
  action {
    action_group = [azurerm_monitor_action_group.logicapp_action_group.id]
  }

  data_source_id = azurerm_log_analytics_workspace.law.id
  description    = "Alert when CPU usage is high"
  severity       = 2
  frequency      = 5
  time_window    = 10
  query          = <<QUERY
Perf
| where ObjectName == "Processor" and CounterName == "% Processor Time"
| summarize avg(CounterValue) by bin(TimeGenerated, 5m)
| where avg_CounterValue > 80
QUERY

  trigger {
    operator  = "GreaterThan"
    threshold = 80
  }

  enabled = true
} ##hey
