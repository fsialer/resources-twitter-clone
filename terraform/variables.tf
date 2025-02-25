variable "AZ_LOCATION" {
  sensitive = true
}
variable "AZ_GROUP_NAME" {
  sensitive = true
}
variable "AZ_PLAN_SERVICE" {
  sensitive = true
}
variable "AZ_STORAGE_NAME" {sensitive = true}
variable "AZ_FUNCTION_NAME" {sensitive = true}
variable "AZ_BUS_SERVICE_NAME" {sensitive = true}
variable "AZ_TOPIC_NAME" {sensitive = true}
variable "AZ_SUBSCRIPTION_NAME" {sensitive = true}
variable "AZ_KEY_VAULT_NAME" {sensitive = true}
variable "AZ_AKS_CLUSTER_NAME" {sensitive = true}
variable "AZ_KEY_AKS_CLUSTER_NAME" {sensitive = true}
variable "ARM_SUBSCRIPTION" {
  sensitive = true
}
variable "ARM_TENANT_ID" {
  sensitive = true
}
variable "CLIENT_ID_CODE_AUTHORIZATION" {
  sensitive = true
}
variable "SECRET_CODE_AUTHORIZATION" {
  sensitive = true
}
variable "CLIENT_ID_CLIENT_CREDENTIALS" {
  sensitive = true
}
variable "CLIENT_SECRET_CLIENT_CREDENTIALS" {
  sensitive = true
}
variable "POSTGRES_USER" {
  sensitive = true
}
variable "POSTGRES_PASSWORD" {
  sensitive = true
}
variable "MONGO_USER" {
  sensitive = true
}
variable "MONGO_PASSWORD" {
  sensitive = true
}
variable "KEY_SECRET" {
  sensitive = true
}
variable "SEND_GRID_SENDER_EMAIL" {
  sensitive = true
}
variable "SEND_GRID_API_KEY" {
  sensitive = true
}
variable "SMTP_SENDER_EMAIL" {
  sensitive = true
}
variable "SMTP_USER" {
  sensitive = true
}
variable "SMTP_PASSWORD" {
  sensitive = true
}
variable "SMTP_HOST" {
  sensitive = true
}
variable "SMTP_PORT" {
  sensitive = true
}
variable "LISTS_SECRETS" {
  type = list(object({
    KEY   = string
    VALUE = string
  }))
  sensitive = true
}


