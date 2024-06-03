terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.7.6"
    }
  }
}

provider "libvirt" {
  alias = "gandalf""
  uri = "qemu+ssh://root@10.3.2.27/system?sshauth=privkey"
}

module "gandalf" {
  source    = "git::https://github.com/ufcg-lsd/terraform-libvirt-module.git"
  providers = {
    libvirt.alternate = libvirt.gandalf
  }
  pool   = "libvirt"
  vcpu   = 2
  memory = "4096"
  disk = 16106127360
  name   = "gandalf"
  networks = [
    {
    "interface" : "eno1",
    "bridge" : "br-133",
    "address" : "10.7.0.27",
    "gateway" : "10.7.0.1",
    "mask" : "24",
    "dns" : "10.7.0.1",
    },
  ]
  cloudinit = {
    hostname       = "gandalf"
    admin_username = "ubuntu"
    admin_password = "admin"
    ssh_authorized_keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD39uXyFANHoJuRsxyMlW2XrFXzcE1lpddKYpr1Lbw/Tj5kjx/y1LOUijiXAb5JXwuJQpQyaM25tuFRUdlSabvfWZVBSS0LaN8BYJJ1sJPd2DKS0NUt7OSm9LP77BhJcODc4ZpbQAKXu4m+Ojx/Ptuo/ArQ75hYSNyng/QvDbl4VWjZglgfogx4u43ahBjRGLneJLukR5ZjIXz+/Ge62Pj0s2nvuUxgt0nyIISu4wlvviTIxLRrsVjUmzA8FhR5s38m9V7nDgBNAan8NgM1QOP7j33mE/UQgxK64N82ctcuPomAKvKumDTXP0k7wyXSGZf23eHjZgdcarjCVOQ++vM9 winiciusallan@steelix.local","ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHsuwxEHxsagSdT6etULTxG2cTw58HYDtYFgiEIVURNf julioalc21@gmail.com"]
  }
  image_source = "/images/ubuntu_22_04.qcow2"
  image_format = "qcow2"
}
