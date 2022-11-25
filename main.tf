terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.5.1"
      # Using this version to get rid of the issue https://github.com/helm/helm/issues/10975
    }
  }
  backend "local" {
    path = "main.tfstate"
  }
}

provider "aws" {
  region     = var.AWS_REGION
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
}

module "demo_vpc" {
  environment    = var.environment
  source         = "./demo-vpc"
  ssh_public_key = var.ssh_public_key
}

provider "helm" {
  kubernetes {
    config_path = "/tmp/kube/config"
  }
}

provider "kubernetes" {
  config_path = "/tmp/kube/config"
}

module "alb_ingress_controller" {
  source            = "./alb-ingress-controller"
  kubernetes_config = module.demo_vpc.kubernetes_config
  vpc_id            = module.demo_vpc.vpc_id
  region            = var.AWS_REGION
  oidc_provider_arn = module.demo_vpc.aws_iam_openid_connect_provider_arn
  cluster_name      = module.demo_vpc.cluster_name
}

module "grafana-prometheus" {
  source               = "./grafana-prometheus"
  name                 = "grafana-prometheus"
  kubernetes_namespace = "grafana-prometheus"
  chart_version        = "2.8.7"
}

variable "environment" {
  default = "dev"
}

variable "ssh_public_key" {
  type    = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC7rPX+PmKMqmiMajEj2KmeROqwMJuuYCsu0akP203hlZLayDDOxt15a2qWiJMB/xhKM4yFxVbz600KGtTptLBAW+Cmzdy4Jpz4JMygubzsF2MYA29WrGmjyO2R/XcctuXMG8QMwpUrzi2o2rfn5C2S8De/9HAHdJ8gt83jv4K1HyA2G2/tsXJG3ReqydfcAtuRbPgmI0nL4oehSM1GzIzM88ESHKVa3K8uXsvQ842JWr/iQjx47H/zlryN5ugUCNdtthhRyRdYmydIFBAFUZ1WPH4fUiHyUj3YY2FgPLkzRV29NdAF5/kOQT8Q6dU/Q2b5ZAlsXAUIjx/jLd5AJW6V2mIk9FwGPIE8Lq9DDXz76//CQpObr1e/FKIhBfomtxkAkQyhtfTwx37f1L34d1Mk9ZRKjsgf9fOyZKubd00Ne9wHr6X4LccriHNg5icBP1V8eNA+ft84J4BpHrFocak+IHuqMQhOXnSadvq2HMBidMGYq8iD0+p9FsW6RywsmY8= gihan@LAPTOP-11G6JPA4"
}

variable "AWS_ACCESS_KEY" {
  default = "AKIA5TUBYTAVEPX2LMC4"
}

variable "AWS_SECRET_KEY" {
  default = "7E4SxbZIGbRAOn4rRRYCye1dYMBv1oVr2Ndwumvf"
}
variable "AWS_REGION" {
  default = "ca-central-1"
}


