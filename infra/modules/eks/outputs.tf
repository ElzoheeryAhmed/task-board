output "cluster_name" {
  value = aws_eks_cluster.eks.name
}

output "oidc_issuer_url" {
  value = aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

output "cluster_endpoint" {
  description = "API server endpoint"
  value       = aws_eks_cluster.eks.endpoint
}

output "cluster_certificate_authority_data" {
  description = "Base64 CA certificate of the cluster"
  value       = aws_eks_cluster.eks.certificate_authority[0].data
}