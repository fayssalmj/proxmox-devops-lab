terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.71.0"
    }
  }
}

provider "proxmox" {
  endpoint  = var.proxmox_api_url
  api_token = var.proxmox_api_token
  insecure  = true
}

resource "proxmox_virtual_environment_vm" "server_aus_vorlage" {
  name      = var.vm_name
  node_name = var.proxmox_node

  clone {
    vm_id = var.template_vm_id
  }

  boot_order = ["scsi0", "net0"]

  cpu {
    cores = var.cpu_cores
  }

  memory {
    dedicated = var.memory_mb
  }

  network_device {
    bridge = "vmbr0"
  }

  initialization {
    datastore_id = "local"

    ip_config {
      ipv4 {
        address = "${var.vm_ip}/24"
        gateway = var.gateway_ip
      }
    }

    user_account {
      keys     = [file("~/.ssh/id_ed25519.pub")]
      username = var.ssh_username
    }
  }

  provisioner "local-exec" {
    command = "sleep 60 && ssh-keygen -R ${var.vm_ip} 2>/dev/null; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${var.vm_ip},' --private-key ~/.ssh/id_ed25519 -u ${var.ssh_username} playbook.yml"
  }
}
