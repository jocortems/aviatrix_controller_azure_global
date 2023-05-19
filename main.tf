terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.8.0"
    }
    null = {
      source = "hashicorp/null"
    }    
      http = {
      source = "hashicorp/http"
      version = "3.2.1"
    }
  }
}

data "azurerm_subscription" "current" {
}

data "http" "my_ip" {
#Get public IP address of system running the code to add to allowed IP addresses of Aviatrix Controller NSG
    url = "http://ipv4.icanhazip.com/"
    method = "GET"
}

module "aviatrix_controller_build" {
  source = "./modules/aviatrix_controller_build"
  // please do not use special characters such as `\/"[]:|<>+=;,?*@&~!#$%^()_{}'` in the controller_name
  controller_name                           = var.controller_name
  location                                  = var.location
  controller_vnet_cidr                      = var.controller_vnet_cidr
  controller_subnet_cidr                    = var.controller_subnet_cidr
  controller_virtual_machine_admin_username = var.controller_virtual_machine_admin_username
  controller_virtual_machine_admin_password = var.controller_virtual_machine_admin_password
  controller_virtual_machine_size           = var.controller_virtual_machine_size
  incoming_ssl_cidr                         = local.allowed_ips
  use_existing_resource_group               = var.use_existing_resource_group
  use_existing_vnet                         = var.use_existing_vnet
  resource_group_name                       = var.resource_group_name
  vnet_name                                 = var.vnet_name
  subnet_name                               = var.subnet_name
}

module "aviatrix_controller_initialize" {
  source                        = "./modules/aviatrix_controller_initialize"
  avx_controller_public_ip      = module.aviatrix_controller_build.aviatrix_controller_public_ip_address
  avx_controller_private_ip     = module.aviatrix_controller_build.aviatrix_controller_private_ip_address
  avx_controller_admin_email    = var.avx_controller_admin_email
  avx_controller_admin_password = var.avx_controller_admin_password
  arm_subscription_id           = data.azurerm_subscription.current.subscription_id
  arm_application_id            = var.avtx_service_principal_appid
  arm_application_key           = var.avtx_service_principal_secret
  directory_id                  = data.azurerm_subscription.current.tenant_id
  account_email                 = var.account_email
  access_account_name           = var.access_account_name
  aviatrix_customer_id          = var.aviatrix_customer_id
  controller_version            = var.controller_version
}
