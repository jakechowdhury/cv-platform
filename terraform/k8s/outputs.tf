output "argocd_cv_gitops_deploy_key_public" {
  value       = tls_private_key.argocd_cv_gitops.public_key_openssh
  sensitive   = false
  description = "Add this as a read-only deploy key in the cv-gitops GitHub repo"
}
