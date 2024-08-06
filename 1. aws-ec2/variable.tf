variable "region" {
  type = string
  description = "Provide region here"
  default = "us-east-1"
}

variable "ami" {
  type        = string
  default     = "ami-04a81a99f5ec58529"
  description = "provide AMI here"
}
