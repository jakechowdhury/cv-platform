locals {
  vms = {
    "k3s-server-01" = {
      vm_id  = 101
      ip     = "192.168.1.101"
      memory = 4096
      cores  = 2
      role   = "server"
    }
    "k3s-server-02" = {
      vm_id  = 102
      ip     = "192.168.1.102"
      memory = 4096
      cores  = 2
      role   = "server"
    }
    "k3s-server-03" = {
      vm_id  = 103
      ip     = "192.168.1.103"
      memory = 4096
      cores  = 2
      role   = "server"
    }
  }
}
