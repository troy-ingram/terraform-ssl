# --- networking/variables.tf ---
variable "target_id" {}
variable "certificate_arn" {}

variable "vpc_cidr" {
  type = string
}

variable "public_cidrs" {
  type = list(any)
}

variable "private_cidrs" {
  type = list(any)
}

variable "availability_zones" {
  type = list(any)
}


