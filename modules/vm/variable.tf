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

variable "vm_subnet_id" {
  type = string
}
