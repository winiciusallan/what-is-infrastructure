# Simple case - PoC

terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.7.6"
    }
  }
}

locals {
  host_user  = "suporte"
  pool_path  = "/home/${local.host_user}/storage/"
  image_path = "/var/lib/libvirt/images/ubuntu22-04.img"
}

provider "libvirt" {
  uri = "qemu:///system"
}

resource "libvirt_pool" "cluster" {
  name = "images"
  type = "dir"
  path = local.pool_path
}

resource "libvirt_volume" "ubuntu22" {
  name = "ubuntu22.qcow2"
  pool   = libvirt_pool.cluster.name
  source = local.image_path
}

output "IPS" {
  value = libvirt_domain.vm1.*.network_interface.0.addresses
}

data "template_file" "user_data" {
  template = file("${path.module}/cloud_init.cfg")
}

data "template_file" "network_config" {
  template = file("${path.module}/network_config.cfg")
}

resource "libvirt_cloudinit_disk" "commoninit" {
  name           = "commoninit.iso"
  user_data      = data.template_file.user_data.rendered
  network_config = data.template_file.network_config.rendered
  pool           = libvirt_pool.cluster.name
}

resource "libvirt_domain" "vm1" {
  name      = "nufuturo"
  memory    = 2048
  vcpu      = 1
  autostart = true

  disk {
    volume_id = libvirt_volume.ubuntu22.id
  }

  cloudinit = libvirt_cloudinit_disk.commoninit.id

  network_interface {
    # default network config 
    network_name = "default"
    addresses      = ["192.168.122.5"]
  }

  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }

}
