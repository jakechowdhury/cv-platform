output "server_ips" {
  description = "k3s server node IPs"
  value       = { for k, v in local.vms : k => v.ip }
}

output "first_server_ip" {
  description = "IP of the first server node (used for cluster-init)"
  value       = local.vms["k3s-server-01"].ip
}
