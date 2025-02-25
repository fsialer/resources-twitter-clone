
resource "azurerm_resource_group" "my_group" {
  name = var.AZ_GROUP_NAME
  location = var.AZ_LOCATION
}

resource "azurerm_service_plan" "plan_service_consumption" {
  name                = var.AZ_PLAN_SERVICE
  location            = azurerm_resource_group.my_group.location
  resource_group_name = azurerm_resource_group.my_group.name
  os_type             = "Linux"
  sku_name            = "Y1"
  depends_on = [azurerm_resource_group.my_group]
}

resource "azurerm_storage_account" "my_storage" {
  name = var.AZ_STORAGE_NAME
  location = azurerm_resource_group.my_group.location
  resource_group_name = azurerm_resource_group.my_group.name
  account_replication_type = "LRS"
  account_tier = "Standard"
  account_kind = "StorageV2"
  depends_on = [azurerm_resource_group.my_group]
}

resource "azurerm_linux_function_app" "my_function" {
  name                       = var.AZ_FUNCTION_NAME
  location                   = azurerm_resource_group.my_group.location
  resource_group_name        = azurerm_resource_group.my_group.name
  service_plan_id            = azurerm_service_plan.plan_service_consumption.id
  storage_account_name       = azurerm_storage_account.my_storage.name
  storage_account_access_key = azurerm_storage_account.my_storage.primary_access_key
  site_config {
    application_stack{
       # name = "java"
       # os = "linux"
       java_version = "21"
    }

  }
  app_settings = {
    FUNCTIONS_EXTENSION_VERSION = "~4"
    FUNCTIONS_WORKER_RUNTIME = "java"  # Especifica el runtime
    WEBSITE_RUN_FROM_PACKAGE = "1"     # Opcional, para ejecutar desde un ZIP
  }
  depends_on = [azurerm_service_plan.plan_service_consumption,azurerm_storage_account.my_storage]
}

resource "azurerm_servicebus_namespace" "my_bus"{
  name = var.AZ_BUS_SERVICE_NAME
  location = azurerm_resource_group.my_group.location
  resource_group_name = azurerm_resource_group.my_group.name
  sku = "Standard"
  depends_on = [azurerm_resource_group.my_group]
}

resource "azurerm_servicebus_topic" "my_topic" {
  name         = var.AZ_TOPIC_NAME
  namespace_id = azurerm_servicebus_namespace.my_bus.id
  depends_on = [azurerm_servicebus_namespace.my_bus]
}

resource "azurerm_servicebus_subscription" "my_subscription" {
  max_delivery_count = 10
  name               = var.AZ_SUBSCRIPTION_NAME
  topic_id           = azurerm_servicebus_topic.my_topic.id
  depends_on = [azurerm_servicebus_topic.my_topic]
}

resource "azurerm_key_vault" "my_vault" {
  location            = azurerm_resource_group.my_group.location
  name                = var.AZ_KEY_VAULT_NAME
  resource_group_name = azurerm_resource_group.my_group.name
  sku_name            = "standard"
  enable_rbac_authorization = true
  tenant_id           = var.ARM_TENANT_ID
  depends_on = [azurerm_resource_group.my_group]
}

resource "azurerm_key_vault_secret" "my_secret" {
  key_vault_id = azurerm_key_vault.my_vault.id
  for_each = {for secret in var.LISTS_SECRETS: secret.KEY => secret.VALUE}
  name         = each.key
  value        = each.value
  depends_on = [azurerm_key_vault.my_vault]
}

resource "azurerm_key_vault_secret" "connection_send_notification" {
  key_vault_id = azurerm_key_vault.my_vault.id
  name         = "connection-send-notification"
  value        = azurerm_servicebus_namespace.my_bus.default_primary_connection_string
  depends_on = [azurerm_key_vault.my_vault,azurerm_servicebus_namespace.my_bus]
}

resource "azurerm_key_vault_key" "my_key" {
  name         = var.AZ_KEY_AKS_CLUSTER_NAME
  key_vault_id = azurerm_key_vault.my_vault.id
  key_type     = "RSA"
  key_size     = 2048
  key_opts = ["encrypt", "decrypt", "sign", "verify"]
}

resource "azurerm_kubernetes_cluster" "my_aks" {
  location            = azurerm_resource_group.my_group.location
  name                = var.AZ_AKS_CLUSTER_NAME
  resource_group_name = azurerm_resource_group.my_group.name
  key_vault_secrets_provider {secret_rotation_enabled = true}
  # key_management_service {
  #   key_vault_key_id = azurerm_key_vault_key.my_key.id
  # }
  dns_prefix = "miaks"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
  depends_on = [azurerm_key_vault_key.my_key,azurerm_resource_group.my_group]
}

