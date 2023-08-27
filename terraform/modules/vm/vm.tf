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
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCisxjw3RFl5alWqKc26I9BjQ2H2an+ZVqBIAXpsLHlBceh06Xz6A3NTgnD+FOWOUfIL+IpkxldGax9cTmkKl/yKnWzL5Kp/LgSIbefhMuThxJhFWWZ0jZtljbC6TREFtWvIvyte3e40uGp+89MeWzZKAoF5bKvgOPbkixRIVTMjmqGtpHssWIee0dLx0KrfViFGawjNDbY1KugoeqCX/pI10eS9ilwbBaA9Kij991c5s7pRvqF54UfgpvcG0coOeH4d70S8vZ5UBmahzFvtamAXoU7a6+cej/hfi2TZup4Ely1kiKv/aj6/640MVosTj3X/0M1lqMjJ6pn5KxihXAChbC1lkJ4bBPinX7bsxt0JxVuxivXPzfUIV2YDFwLNB33nO9hVrSw/4pqPjR9jG96dZ9rz3qKa5aW/Czk61HrrqDKqzmVZVAV5C2KHEgotsN4cNpWiz2y7wJa/f2hcNzD0xJ/Me0OyEmni400ZTDmW9WL311UegtWVSpBg5Jdqls= hoangchu@DESKTOP-L8E01PH"
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
