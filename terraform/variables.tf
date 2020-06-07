#
#  See https://www.terraform.io/intro/getting-started/variables.html for more details.
#

#  Change these defaults to fit your needs!

variable "esxi_hostname" {
  default = "10.0.249.11"
}

variable "esxi_hostport" {
  default = "22"
}

variable "esxi_username" {
  default = "root"
}

variable "esxi_password" { 
  default = "Test1234!"
}

variable "datastore_vm_dir" {
  default = "pxe-server"
}

variable "datastore" {
  default = "openshift_storage"
}

