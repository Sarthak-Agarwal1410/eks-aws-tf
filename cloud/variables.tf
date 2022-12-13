variable "instancetype" {
  default = ["t2.medium", "t2.medium", "t2.medium"]
}

variable "scalemin" {
  default = "1"
}

variable "scalemax" {
  default = "20"
}

variable "scaledesired" {
  default = "1"
}

variable "name" {
  default = "deep-cluster"
}

variable "region" {
  default = "eu-west-2"
}

variable "k8s_cidr_block" {
  default = "10.10.0.0/16"
}

variable "subnet_cidr_block_1a" {
  default = "10.10.1.0/24"
}

variable "subnet_cidr_block_1b" {
  default = "10.10.2.0/24"
}

variable "subnet_cidr_block_1c" {
  default = "10.10.3.0/24"
}

variable "node_count" {
  default = "3"
}