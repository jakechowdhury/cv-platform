variable "proxmox_url" {
  description = "Proxmox API URL"
  type        = string
}

variable "proxmox_token_id" {
  description = "Proxmox API token ID"
  type        = string
}

variable "proxmox_token_secret" {
  description = "Proxmox API token secret"
  type        = string
  sensitive   = true
}

variable "proxmox_node" {
  description = "Proxmox node name"
  type        = string
  default     = "proxmox"
}

variable "template_vm_id" {
  description = "VM ID of the Packer-built template to clone"
  type        = number
  default     = 9000
}

variable "ssh_public_key" {
  description = "SSH public key to inject into VMs"
  type        = string
  sensitive   = true
}
