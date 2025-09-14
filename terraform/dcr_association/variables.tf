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

variable "vm_id" {
  type        = string
  description = "The resource ID of the VM to associate with the DCR"
}
