data "proxmox_virtual_environment_nodes" "available_nodes" {}
data "proxmox_virtual_environment_time" "first_node_time" {
  node_name = data.proxmox_virtual_environment_nodes.available_nodes.names[0]
}

output "nodes" {
  value = data.proxmox_virtual_environment_nodes.available_nodes
}

output "time" {
  value = data.proxmox_virtual_environment_time.first_node_time
}