terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.7.6"
    }
  }
}

provider "libvirt" {
  uri = var.libvirt_uri
}

resource "libvirt_domain" "machine" {
  name = "mordor"
  vcpu = 1
  memory = 2048
}

resource "libvirt_volume" "volume" {

}
