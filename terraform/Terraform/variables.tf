variable "resource_group_name" {
  description = "Azure resource group name"
  type        = string
  default     = "rg-azure-vnet-project"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}
