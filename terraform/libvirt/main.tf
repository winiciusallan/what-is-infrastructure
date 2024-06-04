# Simple case - PoC

terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

provider "libvirt" {
  # uri = "qemu+ssh://root@10.3.2.27/system?keyfile="
  # uri = "qemu+ssh://root@10.3.2.27:22/system?sshauth=ssh-password&keyfile="
  # uri = "qemu:///system" 
}

resource "libvirt_volume" "ubuntu22" {
  name   = "ubuntu22.qcow2"
  #check pool: virsh pool-dumpxml images
  pool   = "images"
  source = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"

}

resource "libvirt_domain" "web1" {
  name   = "test"
  memory = 2048
  vcpu   = 1
  cpu    = {
    mode = "host-passthrough"
  }
  disk {
    volume_id = libvirt_volume.ubuntu22.id

  }
}



