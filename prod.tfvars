vnet = {
  name           = "VN-ASH-CICD-PRD"
  address_space  = ["10.0.0.0/16"]
  subnet_name    = "SB-ASH-CICD-PRD"
  subnet_prefix  = ["10.0.1.0/24"]
  nsg_name       = "P-100-SSH-PRD"
  location       = "westus3"
  resource_group = "RG-ASH-CICD-PRD"
}

vm = {
  vm_name           = "PRD-VM-01"
  location          = "westus3"
  resource_group    = "RG-ASH-CICD-PRD"
  public_ip_name    = "PRD-VM-PublicIP"
  network_interface = "PRD-VM-NIC"
  os_disk_name      = "PRD-VM-OSDisk"
  host_name         = "prdvm"
  size              = "Standard_B2ats_v2"
}
