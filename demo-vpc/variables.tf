variable "AWS_REGION" {
  default = "ca-central-1"
}


variable "AWS_AVAILABILITY_ZONES"  {
  type    = list
  default = ["ca-central-1a","ca-central-1b"]
}

variable "AWS_ACCESS_KEY" {
  default = "AKIA5TUBYTAVEPX2LMC4"
}

variable "AWS_SECRET_KEY" {
  default = "7E4SxbZIGbRAOn4rRRYCye1dYMBv1oVr2Ndwumvf"
}

variable "environment" {
  default = "dev"
}

variable "image" {
  default = "ami-0ee679ef733e3b8e7"
}

variable "num_nodes" {
  type    = number
  default = 3
}

variable "vpc_name" {
  type    = string
  default = "demo vpc"
}

variable "vpc_cidr_block" {
  type = string
  default = "10.100.0.0/20"
}

variable "vpc_private_subnets" {
  type    = list
  default = ["10.100.1.0/24", "10.100.2.0/24"]
}

variable "vpc_public_subnets" {
  type    = list
  default = ["10.100.4.0/24", "10.100.5.0/24"]
}

variable "ssh_public_key" {
  type = string
}