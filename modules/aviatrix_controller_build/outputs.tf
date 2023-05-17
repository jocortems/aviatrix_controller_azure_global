output "aviatrix_controller_public_ip_address" {
  value = azurerm_public_ip.aviatrix_controller_public_ip.ip_address
}

output "aviatrix_controller_private_ip_address" {
  value = azurerm_network_interface.aviatrix_controller_nic.private_ip_address
}

output "aviatrix_controller_vnet" {
  value = azurerm_virtual_network.aviatrix_controller_vnet
}

output "aviatrix_controller_rg" {
  value = azurerm_resource_group.aviatrix_controller_rg
}

output "aviatrix_controller_subnet" {
  value = azurerm_subnet.aviatrix_controller_subnet
}

output "aviatrix_controller_name" {
  value = azurerm_linux_virtual_machine.aviatrix_controller_vm.name
}