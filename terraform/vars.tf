variable "libvirt_uri" {
  type = string
  description = "uri to connect with libvirt"
}

variable "keypair_path" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}
