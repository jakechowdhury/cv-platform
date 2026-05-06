packer {
  required_plugins {
    proxmox = {
      version = "~> 1.1"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

locals {
  ssh_password_hash = bcrypt(var.ssh_password)
}

source "proxmox-iso" "ubuntu-k3s" {
  proxmox_url              = var.proxmox_url
  token                    = var.proxmox_token_secret
  username                 = var.proxmox_token_id
  insecure_skip_tls_verify = true
  node                     = var.proxmox_node

  vm_id   = var.vm_id
  vm_name = "ubuntu-k3s-template"

  boot_iso {
    iso_file     = "local:iso/ubuntu-24.04.3-live-server-amd64.iso"
    iso_checksum = "c3514bf0056180d09376462a7a1b4f213c1d6e8ea67fae5c25099c6fd3d8274b"
    unmount      = true
  }

  cores  = 2
  memory = 2048
  os     = "l26"

  http_content = {
    "/meta-data" = ""
    "/user-data" = templatefile("${path.root}/http/user-data", {
      ssh_password_hash = local.ssh_password_hash
    })
  }

  boot_command = [
    "<wait5>",
    "c<wait10>",
    "linux /casper/vmlinuz quiet autoinstall ds=nocloud-net\\;seedfrom=http://${var.http_ip}:{{ .HTTPPort }}/ ---<enter><wait10>",
    "initrd /casper/initrd<enter><wait10>",
    "boot<enter>"
  ]

  boot_wait = "5s"

  network_adapters {
    bridge   = "vmbr0"
    model    = "virtio"
    firewall = false
  }

  disks {
    type         = "scsi"
    disk_size    = "20G"
    storage_pool = "local-lvm"
    format       = "raw"
  }

  scsi_controller = "virtio-scsi-pci"

  cloud_init              = true
  cloud_init_storage_pool = "local-lvm"

  communicator = "ssh"
  ssh_username = var.ssh_username
  ssh_password = var.ssh_password
  ssh_timeout  = "20m"

  template_name        = "ubuntu-k3s-template"
  template_description = "Ubuntu 24.04 template for k3s - built with Packer"
}

build {
  sources = ["source.proxmox-iso.ubuntu-k3s"]

  # Load kernel modules required by k3s
  provisioner "shell" {
    execute_command = "echo '${var.ssh_password}' | sudo -S -E bash '{{.Path}}'"
    inline = [
      "sudo tee /etc/modules-load.d/k8s.conf <<EOF\noverlay\nbr_netfilter\nEOF",
      "sudo modprobe overlay",
      "sudo modprobe br_netfilter",
    ]
  }

  # Pre-template cleanup
  provisioner "shell" {
    execute_command = "echo '${var.ssh_password}' | sudo -S -E bash '{{.Path}}'"
    inline = [
      "sudo apt-get clean",
      "sudo cloud-init clean",
      "sudo rm -f /etc/ssh/ssh_host_*",
      "sudo truncate -s 0 /etc/machine-id",
    ]
  }
}
