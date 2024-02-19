moved {
  from = azurerm_data_factory_managed_private_endpoint.example
  to   = azurerm_data_factory_managed_private_endpoint.this
}

moved {
  from = module.datalake_access[0]
  to   = module.datalake_access
}