variable "client_id" {
  type = string
}

variable "client_secret" {
  type = string
}

variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "log_analytics_workspace_key" {
  type        = string
  description = "Primary shared key for the Log Analytics workspace"
}
