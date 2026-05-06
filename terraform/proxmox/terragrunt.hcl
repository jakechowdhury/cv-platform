include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  proxmox_url          = get_env("TF_VAR_proxmox_url", "")
  proxmox_token_id     = get_env("TF_VAR_proxmox_token_id", "")
  proxmox_token_secret = get_env("TF_VAR_proxmox_token_secret", "")
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
  terraform {
  required_version = ">= 1.6"
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.50"
    }
  }
}

provider "proxmox" {
  endpoint  = "${local.proxmox_url}"
  api_token = "${local.proxmox_token_id}=${local.proxmox_token_secret}"
  insecure  = true
}
EOF
}
