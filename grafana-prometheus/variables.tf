
variable "kubernetes_namespace" {
  type        = string
  description = "Kubernetes namespace for grafan"
}

variable "name" {
  type        = string
  description = "Name for the grafana service"
}

variable "chart_version" {
  type        = string
  description = "Helm chart version"
}

