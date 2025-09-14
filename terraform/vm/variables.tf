variable "log_analytics_workspace_id" {
  type        = string
  description = "The ID of the Log Analytics workspace to send diagnostics to"
} 
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
