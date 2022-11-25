output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "cluser_id" {
  description = "EKS cluster ID"
  value       = module.eks.cluster_id
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = module.eks.cluster_security_group_id
}

output "region" {
  description = "AWS region"
  value       = var.AWS_REGION
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = local.cluster_name
}

output "kubernetes_config" {
  value = {
    host            = module.eks.cluster_endpoint
    ca_cert         = module.eks.cluster_certificate_authority_data
    oidc_issuer_url = module.eks.cluster_oidc_issuer_url
  }
}

output "aws_iam_openid_connect_provider_arn" {
  value = module.eks.oidc_provider_arn
}
