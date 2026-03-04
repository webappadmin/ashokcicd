# Generate SSH key
resource "tls_private_key" "vm_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create Public IP
resource "azurerm_public_ip" "this" {
  name                = var.vm.public_ip_name
  location            = var.vm.location
  resource_group_name = var.vm.resource_group
# Change these two lines:
  allocation_method   = "Static"   # Standard SKU requires Static
  sku                 = "Standard" # Explicitly use Standard
}

# Create Network Interface
resource "azurerm_network_interface" "this" {
  name                = var.vm.network_interface
  location            = var.vm.location
  resource_group_name = var.vm.resource_group

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = var.vm_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.this.id
  }
}

# Create Linux VM
resource "azurerm_linux_virtual_machine" "this" {
  name                  = var.vm.vm_name
  location              = var.vm.location
  resource_group_name   = var.vm.resource_group
  network_interface_ids = [azurerm_network_interface.this.id]
  size                  = var.vm.size

  os_disk {
    name                 = var.vm.os_disk_name
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  computer_name  = var.vm.host_name
  admin_username = "ashok"

  admin_ssh_key {
    username   = "ashok"
    public_key = tls_private_key.vm_ssh_key.public_key_openssh
  }
}

output "vm_public_ip" {
  value = azurerm_public_ip.this.ip_address
}

output "vm_ssh_private_key" {
  value     = tls_private_key.vm_ssh_key.private_key_pem
  sensitive = true
}
