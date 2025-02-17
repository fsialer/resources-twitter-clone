terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.14.0"
    }
  }
}
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
  enable_rbac_authorization = true
  tenant_id           = ""
}

resource "azurerm_key_vault_secret" "client_id_code_authorization" {
  key_vault_id = azurerm_key_vault.my_vault.id
  name         = "client-id-code-authorization"
  value        = ""
}

resource "azurerm_key_vault_secret" "secret_code_authorization" {
  key_vault_id = azurerm_key_vault.my_vault.id
  name         = "secret-code-authorization"
  value        = ""
}

resource "azurerm_key_vault_secret" "client_id_credentials" {
  key_vault_id = azurerm_key_vault.my_vault.id
  name         = "client-id-client-credentials"
  value        = ""
}

resource "azurerm_key_vault_secret" "secret_credentials" {
  key_vault_id = azurerm_key_vault.my_vault.id
  name         = "client-secret-client-credentials"
  value        = ""
}

resource "azurerm_key_vault_secret" "postgres_user" {
  key_vault_id = azurerm_key_vault.my_vault.id
  name         = "postgres-user"
  value        = ""
}

resource "azurerm_key_vault_secret" "postgres_password" {
  key_vault_id = azurerm_key_vault.my_vault.id
  name         = "postgres-password"
  value        = ""
}

resource "azurerm_key_vault_secret" "mongo_user" {
  key_vault_id = azurerm_key_vault.my_vault.id
  name         = "mongo-user"
  value        = ""
}

resource "azurerm_key_vault_secret" "mongo_password" {
  key_vault_id = azurerm_key_vault.my_vault.id
  name         = "mongo-password"
  value        = ""
}

resource "azurerm_key_vault_secret" "connection_send_notification" {
  key_vault_id = azurerm_key_vault.my_vault.id
  name         = "connection-send-notification"
  value        = ""
}

resource "azurerm_key_vault_secret" "key_secret" {
  key_vault_id = azurerm_key_vault.my_vault.id
  name         = "key-secret"
  value        = ""
}

resource "azurerm_key_vault_secret" "send_grid_sender_email" {
  key_vault_id = azurerm_key_vault.my_vault.id
  name         = "send-grid-sender-email"
  value        = ""
}

resource "azurerm_key_vault_secret" "send_grid_api_key" {
  key_vault_id = azurerm_key_vault.my_vault.id
  name         = "send-grid-api-key"
  value        = ""
}
resource "azurerm_key_vault_secret" "smtp_sender_email" {
  key_vault_id = azurerm_key_vault.my_vault.id
  name         = "smtp-sender-email"
  value        = ""
}

resource "azurerm_key_vault_secret" "smtp_user" {
  key_vault_id = azurerm_key_vault.my_vault.id
  name         = "smtp-user"
  value        = ""
}

resource "azurerm_key_vault_secret" "smtp_password" {
  key_vault_id = azurerm_key_vault.my_vault.id
  name         = "smtp-password"
  value        = ""
}

resource "azurerm_key_vault_secret" "smtp_host" {
  key_vault_id = azurerm_key_vault.my_vault.id
  name         = "smtp-host"
  value        = ""
}
resource "azurerm_key_vault_secret" "smtp_port" {
  key_vault_id = azurerm_key_vault.my_vault.id
  name         = "smtp-port"
  value        = ""
}

resource "azurerm_servicebus_namespace" "my_bus"{
  name = "twitter-clone-bus"
  location = azurerm_resource_group.my_group.location
  resource_group_name = azurerm_resource_group.my_group.name
  sku = "Standard"
}

resource "azurerm_servicebus_topic" "my_topic" {
  name         = "send-notifications"
  namespace_id = azurerm_servicebus_namespace.my_bus.id
}

resource "azurerm_servicebus_subscription" "my_subscription" {
  max_delivery_count = 0
  name               = "notification-post"
  topic_id           = azurerm_servicebus_topic.my_topic.id
}

resource "azurerm_kubernetes_cluster" "my_aks" {
  location            = azurerm_resource_group.my_group.location
  name                = "twitter-clone-aks"
  resource_group_name = azurerm_resource_group.my_group.name
  key_vault_secrets_provider {secret_rotation_enabled = true}
  key_management_service {
    key_vault_key_id = azurerm_key_vault.my_vault.id
  }
  dns_prefix = "miaks"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}

