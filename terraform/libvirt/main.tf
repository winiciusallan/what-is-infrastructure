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
  uri = "qemu+ssh://suporte@10.3.2.27/system?sshauth=ssh-password"
  # uri = "qemu:///system" 
}

resource "libvirt_volume" "ubuntu22" {
  name   = "ubuntu22.qcow2"
  #check pool: virsh pool-dumpxml images
  pool   = "images"
  source = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"

}

resource "libvirt_domain" "test" {
  name = "test"
  memory = 2048
  vcpu = 1
  cpu {
    mode = "host-passthrough"
  }
  autostart = true

  disk {
    volume_id = libvirt_volume.ubuntu22.id
  }

  cloudinit = libvirt_cloudinit_disk.commoninit.id

  network_interface {
  # default network config 
  # network_name = "default"
    bridge =  "br0"
  }
  
  qemu_agent = true

}

output "IPS" {
  value = libvirt_domain.test.*.network_interface.0.addresses
}

data "template_file" "user_data" {
  template = file("${path.module}/cloud_init.cfg")
}

resource "libvirt_cloudinit_disk" "commoninit" {
  name           = "commoninit.iso"
  user_data      = data.template_file.user_data.rendered
  pool           = "images"
}
