variable "proxmox_api_url" {
  type        = string
  default     = "https://10.0.10.5:8006/"
  description = "URL der Proxmox API"
}

variable "proxmox_api_token" {
  type        = string
  sensitive   = true
  description = "API-Token für Proxmox"
}

variable "vm_name" {
  type        = string
  default     = "mein-fertiger-server"
  description = "Name der VM"
}

variable "proxmox_node" {
  type        = string
  default     = "lab"
  description = "Proxmox Node Name"
}

variable "template_vm_id" {
  type        = number
  default     = 9000
  description = "ID der Template-VM"
}

variable "cpu_cores" {
  type        = number
  default     = 2
  description = "Anzahl CPU-Kerne"
}

variable "memory_mb" {
  type        = number
  default     = 2048
  description = "Arbeitsspeicher in MB"
}

variable "vm_ip" {
  type        = string
  default     = "10.0.10.13"
  description = "IP-Adresse der VM"
}

variable "gateway_ip" {
  type        = string
  default     = "10.0.10.1"
  description = "Gateway IP-Adresse"
}

variable "ssh_username" {
  type        = string
  default     = "fayssal"
  description = "SSH-Benutzername"
}
