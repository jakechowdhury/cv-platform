include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "proxmox" {
  config_path                             = "../proxmox"
}

dependency "cloudflare" {
  config_path                             = "../cloudflare"
}

inputs = {
  cloudflared_tunnel_token = dependency.cloudflare.outputs.tunnel_token
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_version = ">= 1.6"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}

  provider "helm" {
  kubernetes = {
    config_path    = "~/.kube/config"
    config_context = "k3s-homelab"
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "k3s-homelab"
}

provider "random" {}

provider "tls" {}

EOF
}
