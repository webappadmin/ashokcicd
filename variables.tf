variable "vnet" {
  type = object({
    name           = string
    address_space  = list(string)
    subnet_name    = string
    subnet_prefix  = list(string)
    nsg_name       = string
    location       = string
    resource_group = string
  })
}
variable "vm" {
  type = object({
    vm_name           = string
    location          = string
    resource_group    = string
    public_ip_name    = string
    network_interface = string
    os_disk_name      = string
    host_name         = string
    size              = string
  })
}
variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}
variable "client_id" {
  description = "Azure AD Application Client ID"
  type        = string
}
variable "client_secret" {
  description = "Azure AD Application Client Secret"
  type        = string
  sensitive   = true
}
variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}
variable "resource_group_name" {
  default = "company-1"
}

