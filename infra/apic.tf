resource "azurerm_resource_group_template_deployment" "apic" {
  resource_group_name = local.rg_name
  template_content    = file("./apic.json")
  name                = "deploy-apic-demo"
  deployment_mode     = "Incremental"
}
