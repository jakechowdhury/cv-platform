variable "cloudflare_api_token" {
  description = "Cloudflare API token with Zone:DNS:Edit and Tunnel:Edit permissions"
  type        = string
  sensitive   = true
}

variable "cloudflare_account_id" {
  description = "Cloudflare account ID"
  type        = string
}

variable "cloudflare_zone_name" {
  description = "Cloudflare zone name"
  type        = string
  default     = "jakechowdhury.co.uk"
}
