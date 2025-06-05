terraform {
  required_version = ">= 1.11.4"
  required_providers {
    onepassword = {
      source  = "1Password/onepassword"
      version = "2.1.2"
    }
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.70.0"
    }
  }
}

variable "onepassword_sa_token" {
  type = string
  sensitive = true
}

provider "onepassword" {
  service_account_token = var.onepassword_sa_token
}

data "onepassword_item" "proxmox_token" {
  vault = "immanent-grove"
  title = "proxmox-api-token"
}

data "onepassword_item" "proxmox_ssh" {
  vault = "immanent-grove"
  title = "proxmox-ssh"
}

# Provide SSH access to all nodes as well as an admin API token
provider "proxmox" {
  endpoint  = "https://havnor.pve.apicius.local:8006/"
  insecure  = true
  api_token = data.onepassword_item.proxmox_token

  ssh {
    agent    = true
    username = data.onepassword_item.proxmox_ssh.username
    password = data.onepassword_item.proxmox_ssh.password
  }
}