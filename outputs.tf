
output "kubeconfig" {
  value       = module.eks.eks_kubeconfig
  description = "EKS Kubeconfig"
}

output "config-map" {
  value       = module.eks.config-map
  description = "K8S config map to authorize"
}
