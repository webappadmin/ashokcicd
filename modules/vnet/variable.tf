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