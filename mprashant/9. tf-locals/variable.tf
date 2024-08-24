variable "aws_instance_type" {
  description = "what type of instance you want to create?"
  type = string

  validation {
    condition = var.aws_instance_type=="t2.micro" || var.aws_instance_type=="t3.micro"
    error_message = "Only t2 and t3 micro is allowed"
  }
}

variable "ec2_config" {
  description = "provide the value for volume type and volume size"
  type = object({
    vol_type = string
    vol_size = number 
  })

  validation {
    condition = var.ec2_config.vol_size<=30
    error_message = "size should be less than or equal to 30"
  }
}

variable "additional_tags" {
  type = map(string) # Expecting key value pair
}