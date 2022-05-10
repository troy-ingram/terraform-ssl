# --- compute/variables.tf ---

variable "web_sg" {}
variable "public_subnet" {}
variable "private_subnet" {}
variable "vpc_security_group_ids" {}


variable "web_instance_type" {
  type    = string
  default = "t2.micro"
}

