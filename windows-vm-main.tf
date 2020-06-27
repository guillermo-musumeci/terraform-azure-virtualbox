#######################
## Windows VM - Main ##
#######################

# Bootstrapping Script
data "template_file" "tf-setup" {
  template = "${file("${path.module}/setup.ps1")}"
}

# Get a Static Public IP
resource "azurerm_public_ip" "windows-vm-ip" {
  name                = "${var.windows-vm-hostname}-ip"
  location            = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name
  allocation_method   = "Static"
  
  tags = { 
    environment = var.environment 
  }
}

# Create Network Card for VM
resource "azurerm_network_interface" "windows-vm-nic" {
  name                = "${var.windows-vm-hostname}-nic"
  location            = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.network-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.windows-vm-ip.id
  }

  tags = { 
    environment = var.environment 
  }
}

# Create Windows Virtual Machine
resource "azurerm_windows_virtual_machine" "windows-vm" {
  name                  = var.windows-vm-hostname
  location              = azurerm_resource_group.network-rg.location
  resource_group_name   = azurerm_resource_group.network-rg.name
  size                  = var.windows-vm-size
  network_interface_ids = [azurerm_network_interface.windows-vm-nic.id]
  
  computer_name         = var.windows-vm-hostname
  admin_username        = var.windows-admin-username
  admin_password        = var.windows-admin-password

  os_disk {
    name                 = "${var.windows-vm-hostname}-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = var.windows-vm-os-disk
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = var.windows-2019-sku
    version   = "latest"
  }

  enable_automatic_updates = true
  provision_vm_agent       = true

  tags = {
    environment = var.environment 
  }
}

# Windows VM virtual machine extenstion - Run configuration Scripts
resource "azurerm_virtual_machine_extension" "windows-vm-extension" {
  depends_on=[azurerm_windows_virtual_machine.windows-vm]

  name                 = "${var.windows-vm-hostname}-vm-extension"
  virtual_machine_id   = azurerm_windows_virtual_machine.windows-vm.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"  
  settings = <<SETTINGS
  {
    "commandToExecute": "powershell -command \"[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('${base64encode(data.template_file.tf-setup.rendered)}')) | Out-File -filepath setup.ps1\" && powershell -ExecutionPolicy Unrestricted -File setup.ps1"
  }
  SETTINGS

  tags = {
    environment = var.environment
  }
}

