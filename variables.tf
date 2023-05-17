variable "access_account_name" {
  type        = string
  description = "aviatrix controller access account name"
}

variable "account_email" {
  type        = string
  description = "aviatrix controller access account email"
}

variable "aviatrix_customer_id" {
  type        = string
  description = "aviatrix customer license id"
}

variable "avx_controller_admin_email" {
  type        = string
  description = "aviatrix controller admin email address"
}

variable "avx_controller_admin_password" {
  type        = string
  description = "aviatrix controller admin password"
}

variable "controller_name" {
  type        = string
  description = "Customized Name for Aviatrix Controller"
}
variable "controller_subnet_cidr" {
  type        = string
  description = "CIDR for controller subnet."
  default     = "10.0.0.0/24"
}

variable "controller_version" {
  type        = string
  description = "Aviatrix Controller version"
  default     = "latest"
}

variable "controller_virtual_machine_admin_username" {
  type        = string
  description = "Admin Username for the controller virtual machine."
  default     = "aviatrix"
}

variable "controller_virtual_machine_admin_password" {
  type        = string
  description = "Admin Password for the controller virtual machine."
  default     = "aviatrix1234!"
}

variable "controller_virtual_machine_size" {
  type        = string
  description = "Virtual Machine size for the controller."
  default     = "Standard_D4s_v5"
}

variable "controller_vnet_cidr" {
  type        = string
  description = "CIDR for controller VNET."
  default     = "10.0.0.0/24"
}

variable "incoming_ssl_cidr" {
  type        = list(string)
  description = "Incoming cidr for security group used by controller"
}

variable "location" {
  type        = string
  description = "Resource Group Location for Aviatrix Controller"
  default     = "West US"
}

variable "avtx_service_principal_secret" {
  type = string
  description = "This is the secret of the AppID created for the Aviatrix Controller"
  sensitive = true
}

variable "avtx_service_principal_appid" {
  type = string
  description = "This is the AppID of the Service Principal created for the Aviatrix Controller"
  sensitive = true
}

locals {
  provisionerIP = [replace(data.http.my_ip.response_body,"\n","/32")]
  allowed_ips = length(var.incoming_ssl_cidr) > 0 ? concat(var.incoming_ssl_cidr,local.provisionerIP) : local.provisionerIP
}