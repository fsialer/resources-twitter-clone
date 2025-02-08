provider "azurerm" {
  feature {}
}

resource "azurerm_resource_group" "my_group" {
  name = "gr-twitter-clone"
  location = "East Us"
}

resource "azurerm_key_vault" "my_vault" {
  location            = azurerm_resource_group.my_group.location
  name                = "twitter-clone-vault"
  resource_group_name = azurerm_resource_group.my_group.name
  sku_name            = "standard"
  tenant_id           = ""
}

resource "azurerm_servicebus_namespace" "my_bus"{
  name = "twitter-clone-bus"
  location = azurerm_resource_group.my_group.location
  resource_group_name = azurerm_resource_group.my_group.name
  sku = "Standard"
}

resource "azurerm_kubernetes_cluster" "my_aks" {
  location            = azurerm_resource_group.my_group.location
  name                = "twitter-clone-aks"
  resource_group_name = azurerm_resource_group.my_group.name
  dns_prefix = "miaks"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}

