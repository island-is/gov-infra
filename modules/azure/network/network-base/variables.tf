# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir
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

variable "delegations" {
  description = "A list of delegations to create for the subnet"
  type = list(object({
    name = string
    service_delegation = object({
      name    = string
      actions = list(string)
    })
  }))
  default = []
}

variable "public_ip_name_override" {
  description = "The name override of the public IP address"
  type        = string
  default     = ""
}

variable "vnet_name_override" {
  description = "The name override of the virtual network"
  type        = string
  default     = null
}

variable "subnet_name_override" {
  description = "The name override of the subnet"
  type        = string
  default     = null
}

variable "security_group_rules" {
  description = <<DESC
  A map of security group rules to create. The key is the name of the rule.
  Example:
  security_group_rules = {
    "Allow-All-Inbound" : {
      description = "Allow all inbound traffic"
      access = "Allow"
      direction = "Inbound"
      priority = 100
      protocol = "Tcp"
      source_port_range = "*"
      destination_port_range = "*"
      source_address_prefix = "*" | "AzureDevOps"
      destination_address_prefix = "*"
    }
  }
  DESC

  type = map(object({
    protocol  = string
    priority  = number
    direction = string
    access    = string

    description                  = optional(string)
    source_port_range            = optional(string)
    destination_port_range       = optional(string)
    source_address_prefix        = optional(string)
    source_address_prefixes      = optional(list(string))
    destination_address_prefix   = optional(string)
    destination_address_prefixes = optional(list(string))
  }))
}
