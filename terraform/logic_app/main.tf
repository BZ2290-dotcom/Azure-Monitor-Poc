resource "azurerm_resource_group_template_deployment" "logic_app" {
  name                = "poc-logicapp-deployment"
  resource_group_name = "poc-monitor-rg"
  deployment_mode     = "Incremental"

  template_content = file("${path.module}/logicapp-template.json")

  parameters_content = jsonencode({
    logicAppName = {
      value = "poc-alert-handler"
    }
  })
}
