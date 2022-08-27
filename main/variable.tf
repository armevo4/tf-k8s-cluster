variable "env_prefix" {   
    type = string
    default = "kgk"
}

variable "vpc_cidr_block" {
  type    = string
  default = "192.168.0.0/16"
}

variable "pub_sub_cidr_block" {
  type    = string
  default = "192.168.1.0/24"
}

variable "priv_sub_cidr_block" {
  type    = string
  default = "192.168.2.0/24"
}