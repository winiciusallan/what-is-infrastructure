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
  host_user = "suporte"
  pool_path = "/home/${local.host_user}/storage/"
}

provider "libvirt" {
  # uri = "qemu+ssh://suporte@10.3.2.27/system?keyfile="
  # uri = "qemu+ssh://suporte@10.3.2.27/system?sshauth=ssh-password"
  uri = "qemu+ssh://suporte@10.3.2.27/system?sshauth=privkey"
}

resource "libvirt_pool" "cluster" {
  name = "images"
  type = "dir"
  path = local.pool_path
}

resource "libvirt_volume" "ubuntu22" {
  name = "ubuntu22.qcow2"
  #check pool: virsh pool-dumpxml images
  pool   = libvirt_pool.cluster.name
  source = "/home/${local.host_user}/jammy-server-cloudimg-amd64.img"
}

output "IPS" {
  value = libvirt_domain.vm1.*.network_interface.0.addresses
}

data "template_file" "user_data" {
  template = file("${path.module}/cloud_init.cfg")
}

resource "libvirt_cloudinit_disk" "commoninit" {
  name      = "commoninit.iso"
  user_data = data.template_file.user_data.rendered
  pool      = libvirt_pool.cluster.name
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
    # network_name = "default"
    bridge = "br0"
  }

  qemu_agent = true

}
