data "proxmox_virtual_environment_nodes" "available_nodes" {}

output "nodes" {
  value = data.proxmox_virtual_environment_nodes.available_nodes
}