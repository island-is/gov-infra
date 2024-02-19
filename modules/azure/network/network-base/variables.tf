variable "org_code" {
  description = "Org code"
  type        = string
}

variable "tier" {
  type        = string
  description = "The tier of the environment (e.g. test, prod)"
}

variable "instance" {
  description = "Identifier for the application, workload or service"
  type        = string
}

variable "resource_group_info" {
  description = "The name and location of the Resource Group into which the app service should be placed."
  type = object({
    id       = string
    name     = string
    location = string
  })
}

variable "virtual_network_cidr" {
  description = "The CIDR of the Virtual Network"
  type        = string
}

variable "subnet_cidr" {
  description = "The CIDR of the default subnet"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "private_dns_suffix" {
  description = "The private DNS suffix of the Azure region"
  type        = string
  default     = "private.northeurope.azmk8s.io"
}

variable "create_nat_gateway" {
  description = "Create a NAT Gateway"
  type        = bool
  default     = false
}

variable "service_endpoints" {
  description = "A list of service endpoints to enable on the subnet"
  type        = list(string)
  default     = []
}

variable "create_delegation" {
  description = "Create a delegation for the subnet"
  type        = bool
  default     = false
}

variable "public_ip_name_override" {
  description = "The name override of the public IP address"
  type        = string
  default     = ""
}

variable "vnet_name_override" {
  description = "The name override of the virtual network"
  type        = string
  default     = ""
}
