variable "libvirt_uri" {
  type = string
}

variable "keypair_path" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}
