resource "proxmox_virtual_environment_vm" "k3s_vms" {
  for_each    = local.vms
  name        = each.key
  description = "K3s ${each.value.role} node - managed by Terraform"
  vm_id       = each.value.vm_id
  node_name   = var.proxmox_node
  tags        = ["k3s", each.value.role, "terraform"]

  clone {
    vm_id = var.template_vm_id
    full  = true
  }

  cpu {
    cores = each.value.cores
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = each.value.memory
  }

  network_device {
    bridge = "vmbr0"
    model  = "virtio"
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    size         = 20
  }

  initialization {
    ip_config {
      ipv4 {
        address = "${each.value.ip}/24"
        gateway = "192.168.1.1"
      }
    }
    user_account {
      username = "k3s-admin"
      keys     = [var.ssh_public_key]
    }
    dns {
      servers = ["8.8.8.8", "8.8.4.4"]
    }
  }

  agent {
    enabled = true
  }

  lifecycle {
    ignore_changes = [
      initialization[0].user_account[0].keys,
    ]
  }
}
