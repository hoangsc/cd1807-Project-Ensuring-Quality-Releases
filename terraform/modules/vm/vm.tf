resource "azurerm_network_interface" "test" {
  name                = "${var.application_type}-${var.resource_type}-ni"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${var.public_ip}"
  }
}

resource "azurerm_linux_virtual_machine" "test" {
  name                = "${var.application_type}-${var.resource_type}-vm"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
  size                = "Standard_DS2_v2"
  admin_username      = "${var.admin_username}"
  admin_password      = "${var.admin_password}"
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.test.id]
  admin_ssh_key {
    username   = "${var.admin_username}"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDWDaleWds4UqUb8QErdYYiIoW+4lve6jXmRBP0PJwHmh/sjKmJDT2MuCaxIpKz60+KlkQLda58/5l1Nqq8Fb1qWvKACh9xXmpbdnV7mqntf1X3UnldbX4jfQpgwLHEu0u9O+PDtSr2hvtTmcOsAqgxwZKdEeq1S+fFyhoqcNWuzaa+/Xr650JszpzVmtjtYWC70uVhHY4KBra1sdH8qQriIFbdqeCfgPhbYlVgT8Sb+HHgbM7Y6fMSUvMjDqGkXPpxDS2/CEWqSGbesGVyjlrg5k5N58mS8yfikaHvD04lqhOedA9X878ItYSS0+CMQ+cws6XvWlbLkC+NWFnxPUV6BV1dxM994eep6Q5yWZM7y9A8kugW7Y5N32eyL1vU5btB2M9yZfzn4cf9d4m7fh0hyTAl9aVet+r40gNuiqLvlLiu8jXtynb9xT8CcEgkD4CwEYlnX4yo5J2CVVvLwGu/XxktTOyQTt8medobFGeZaKNrtD5JbXKAq76Zyf4ielM= odl_user@cc-3147c886-7b86b5d5cc-bh9g6"
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
