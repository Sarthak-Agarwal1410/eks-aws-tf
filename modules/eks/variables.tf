variable "disk_size" {
  type = map(any)
  default = {
    0 = "100"
    1 = "80"
    2 = "70"
    3 = "100"
    4 = "50"
  }
}

variable "labels" {
  type = map(any)
  default = {
    0 = "deep-prod-teacher-dashboard"
    1 = "deep-prod-chatbot-v2"
    2 = "deep-prod-mpu-v2"
    3 = "deep-prod-vision"
    4 = "service"
  }
}

variable "name" {
  type = string
}

variable "region" {
  type = string
}

variable "node_count" {
  type = string
}

variable "sshkey" {
  type = string
}

variable "k8s_subnets" {
  type = list(any)
}

variable "instancetype" {
  type = list(any)
}

variable "scalemin" {
  type = number
}

variable "scalemax" {
  type = number
}

variable "scaledesired" {
  type = number
}

variable "k8s_cidr_block" {
  type = string
}

variable "role_arn" {}

variable "kubernetes_vpc_id" {}