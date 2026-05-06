resource "cloudflare_zero_trust_tunnel_cloudflared" "cv_site" {
  account_id = var.cloudflare_account_id
  name       = "cv-platform-homelab"
  secret     = random_password.tunnel_secret.result
  config_src = "cloudflare"
}

resource "random_password" "tunnel_secret" {
  length  = 32
  special = false
}

resource "cloudflare_zero_trust_tunnel_cloudflared_config" "cv_site" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.cv_site.id

  config {
    ingress_rule {
      hostname = "cv.jakechowdhury.co.uk"
      service  = "http://cv-site.cv-site.svc.cluster.local:80"
    }

    ingress_rule {
      service = "http_status:404"
    }
  }
}

resource "cloudflare_record" "cv_site" {
  zone_id = data.cloudflare_zones.cv_site.zones[0].id
  name    = "cv"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.cv_site.id}.cfargotunnel.com"
  type    = "CNAME"
  proxied = true
}
