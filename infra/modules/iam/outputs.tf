output "cluster_role_arn" {
  description = "ARN of the IAM role the EKS control plane assumes"
  value       = aws_iam_role.cluster.arn
}

output "node_role_arn" {
  description = "ARN of the IAM role used by the worker nodes"
  value       = aws_iam_role.node.arn
}

output "ebs_csi_role_arn" {
  description = "ARN of the IAM role for the EBS CSI driver."
  value       = aws_iam_role.ebs_csi.arn
}

############We can use it to write and attach policy wheeeeen creating ALB

output "oidc_provider_arn" {
  value = aws_iam_openid_connect_provider.eks.arn
}

output "oidc_host" {
  value = local.oidc_host
}