#########################
## Network - Variables ##
#########################

variable "vnet-cidr" {
  type        = string
  description = "CIDR of the VNET"
}

variable "subnet-cidr" {
  type        = string
  description = "CIDR for the Subnet "
}
