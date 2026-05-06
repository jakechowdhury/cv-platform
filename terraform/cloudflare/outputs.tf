output "tunnel_token" {
  value = base64encode(jsonencode({
    a = var.cloudflare_account_id
    t = cloudflare_zero_trust_tunnel_cloudflared.cv_site.id
    s = random_password.tunnel_secret.result
  }))
  sensitive = true
}
