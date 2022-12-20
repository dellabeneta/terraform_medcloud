variable "availability_zones_count" {
  type    = number
  default = 6
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_cidr_bits" {
  type    = number
  default = 8
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "project" {
  default = "medcloud"
}

variable "rds_dbname" {
  default = "medcloud-dbname"
}

variable "rds_username" {
  default = "medcloud-dbuser"
}