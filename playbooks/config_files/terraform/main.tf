provider "vsphere" {
  vsphere_server = var.vsphere_server
  user = var.vsphere_user
  password = var.vsphere_password
  allow_unverified_ssl = true
}

# --- VARIABLE-DECLARATION

data "vsphere_datacenter" "dc" {
  name = "dc-home"
}

data "vsphere_compute_cluster" "cluster" {
  name = "cluster-home"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name = "rp-home"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore" {
  name = "openshift_storage"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name = "dpg-home-prod"
  datacenter_id = data.vsphere_datacenter.dc.id
}

variable "ocp-folder" {
  default = "/dc-home/vm/spielwiese"
}

# --- Create VM OCP-Bastion-Host --- #
resource "vsphere_virtual_machine" "test-clone" {

  name = var.vm_name_clone_test_sva
  folder = var.ocp-folder
  guest_id = var.master_guest_id_tag
  resource_pool_id = data.vsphere_resource_pool.pool.id
  firmware = "bios"
  datastore_id = data.vsphere_datastore.datastore.id
  num_cpus = 2
  memory = 4096
  wait_for_guest_ip_timeout = 0
  wait_for_guest_net_timeout = 0
  network_interface {
    network_id = data.vsphere_network.network.id
    adapter_type = "vmxnet3"
  }
  disk {
    label = "rootvolume"
    size  = "120"
    thin_provisioned  = "true"
  }
  clone {
    template_uuid = "4226b890-4986-d6b5-f3ef-e3458f22cfee"
    customize {
      linux_options {
        host_name = "cloned"
        domain = "home.local"
      }
      network_interface { }
    }
  }
}
