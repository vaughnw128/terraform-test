data "proxmox_virtual_environment_nodes" "available_nodes" {}
data "proxmox_virtual_environment_time" "first_node_time" {
  node_name = data.proxmox_virtual_environment_nodes.available_nodes.names[0]
}

resource "proxmox_virtual_environment_download_file" "twice_cooked_pork" {
  for_each     = toset(for node in data.proxmox_virtual_environment_nodes.available_nodes.names)
  content_type = "jpg"
  datastore_id = "local"
  node_name    = each.value

  file_name               = "twice-cooked-pork.jpg"
  url                     = "https://s3.vaughn.sh/cdn/pan.jpg"
  overwrite               = true
}

output "nodes" {
  value = data.proxmox_virtual_environment_nodes.available_nodes
}

output "time" {
  value = data.proxmox_virtual_environment_time.first_node_time
}