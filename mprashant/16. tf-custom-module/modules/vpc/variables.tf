variable "vpc_config" {
  description = "To get the CIDR and Name of the VPC from user."
  type = object({
    name = string
    cidr_block_vpc = string
  })

  validation {
    condition = can(cidrnetmask(var.vpc_config.cidr_block_vpc))
    error_message = "Invalid CIRD - ${var.vpc_config.cidr_block_vpc}"
  }
}

variable "subnet_config" {
  # sub1={ cidr=... az=...} sub2={...} sub3={...}
  type = map(object({
    cidr_block_subnet = string
    az = string
    public = optional(bool, false)
  }))

  validation {
    condition = alltrue([for cidr in var.subnet_config: can(cidrnetmask(cidr.cidr_block_subnet))])
    error_message = "Invalid CIRD format"
  }  
}