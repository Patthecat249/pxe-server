# vcenter-connection
variable "vsphere_server" {
  default = "vcenter.home.local"
}

variable "vsphere_user" {
  default = "administrator@home.local"
}

variable "vsphere_password" { 
  default = "Test1234!"
}

# VM-name
variable "vm_name_clone_test_sva" {
  default = "test-sva-clone"
}

variable "vm_folder" {
  default = "spielwiese"
}


variable "master_guest_id_tag" {
  default = "centos7_64Guest"
#  default = "centos8_64Guest"
#  default = "rhel7_64Guest"
#  default = "rhel8_64Guest"
#  default = "ubuntuGuest"
#  default = "ubuntu64Guest"
#  default = "coreos64Guest"
}
variable "worker_guest_id_tag" {
  default = "centos7_64Guest"
#  default = "centos8_64Guest"
#  default = "rhel7_64Guest"
#  default = "rhel8_64Guest"
#  default = "ubuntuGuest"
#  default = "ubuntu64Guest"
#  default = "coreos64Guest"
}

# vcenter-objects
variable "vsphere_datacenter" {
  default = "dc-home"
}

variable "vsphere_compute_cluster" {
  default = "cluster-home"
}

variable "vsphere_resource_pool" {
  default = "rp-home"
}

variable "vsphere_datastore" {
  default = "openshift_storage"
}

variable "vsphere_network" {
  default = "dpg-home-prod"
}

