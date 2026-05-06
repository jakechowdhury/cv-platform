variable "proxmox_url" {
  type    = string
}

variable "proxmox_token_id" {
  type    = string
}

variable "proxmox_token_secret" {
  type      = string
  sensitive = true
}

variable "proxmox_node" {
  type    = string
  default = "proxmox"
}

variable "vm_id" {
  type    = number
  default = 9000
}

variable "http_ip" {
  type    = string
}

variable "ssh_username" {
  type    = string
  default = "ubuntu"
}

variable "ssh_password" {
  type      = string
  sensitive = true
}
