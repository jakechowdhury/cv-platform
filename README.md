# cv-platform

Infrastructure-as-code for a self-hosted CV site running on a Proxmox homelab. Provisions VMs, bootstraps a k3s cluster, and exposes the site publicly via a Cloudflare tunnel — no open inbound ports required.

## Architecture

```
Proxmox
└── 3x Ubuntu VMs (k3s-server-01/02/03)  ← Packer image + Terraform + Ansible
    └── k3s cluster
        ├── ArgoCD  ← pulls from jakechowdhury/cv-gitops
        │   └── cv-site app (served from ghcr.io)
        └── cloudflared  ← Cloudflare Zero Trust tunnel
            └── cv.jakechowdhury.co.uk
```

State is stored in S3 (`eu-west-2`), encrypted at rest.

## Repository layout

```
├── packer/          # Ubuntu 24.04 VM template with k3s prerequisites baked in
├── terraform/
│   ├── proxmox/     # Clone template → 3 k3s VMs
│   ├── k8s/         # ArgoCD, Cloudflare tunnel secret, GHCR pull secret
│   └── cloudflare/  # Zero Trust tunnel + CNAME DNS record
├── ansible/         # Common node config + k3s install/join
└── renovate.json    # Automated dependency updates
```

## Prerequisites

- Proxmox VE node with an [API token](https://pve.proxmox.com/wiki/User_Management#pveum_tokens) configured
- S3 bucket for Terraform state (set `S3_STATE_BUCKET` env var)
- Cloudflare account with the domain managed there
- Terraform, Terragrunt, Packer, Ansible installed locally

## Usage

### 1. Build the VM template

```bash
cd packer
packer init .
packer build .
```

### 2. Provision VMs

```bash
cd terraform/proxmox
terragrunt apply
```

### 3. Bootstrap k3s

```bash
cd ansible
ansible-playbook -i inventory/hosts.ini playbooks/site.yml
```

### 4. Fetch kubeconfig

```bash
ssh k3s-admin@192.168.1.101 "sudo cat /etc/rancher/k3s/k3s.yaml" \
  | sed 's/127.0.0.1/192.168.1.101/g' \
  > ~/.kube/config
kubectl config rename-context default k3s-homelab
```

### 5. Configure Cloudflare tunnel

```bash
cd terraform/cloudflare
terragrunt apply
```

### 6. Deploy cluster workloads

```bash
cd terraform/k8s
terragrunt apply
```

ArgoCD will then sync the `cv-gitops` repo and deploy the CV site automatically.

## Teardown

Destroy in reverse order to avoid dependency errors.

### 1. Remove cluster workloads

```bash
cd terraform/k8s
terragrunt destroy
```

### 2. Remove Cloudflare tunnel

```bash
cd terraform/cloudflare
terragrunt destroy
```

### 3. Destroy VMs

```bash
cd terraform/proxmox
terragrunt destroy
```

The Packer-built VM template must be deleted manually from the Proxmox UI (or via `qm destroy <vmid>`).

## Secrets

Copy `example.env` to `dev.env` and populate the values. Files matching `*.env`, `*.tfvars`, and `*.auto.pkrvars.hcl` are gitignored.

## Development

Pre-commit hooks enforce formatting, linting, and secret detection:

```bash
pip install pre-commit
pre-commit install
```
