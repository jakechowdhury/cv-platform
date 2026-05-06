variable "ghcr_username" {
  description = "GitHub username for GHCR image pull"
  type        = string
  default     = "jakechowdhury"
}

variable "ghcr_token" {
  description = "GitHub PAT with read:packages scope for GHCR image pull"
  type        = string
  sensitive   = true
}

variable "cloudflared_tunnel_token" {
  description = "Cloudflare Tunnel token — passed from cloudflare module output"
  type        = string
  sensitive   = true
}
