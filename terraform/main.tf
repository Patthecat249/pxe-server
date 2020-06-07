provider "esxi" {
  esxi_hostname = var.esxi_hostname
  esxi_hostport = var.esxi_hostport
  esxi_username = var.esxi_username
  esxi_password = var.esxi_password
}

# Create PXE-Server-Additional-Volume
resource "esxi_virtual_disk" "additional01" {
  virtual_disk_disk_store = var.datastore
  virtual_disk_dir = var.datastore_vm_dir
  virtual_disk_name = "pxe-root01.vmdk"
  virtual_disk_size = 60
  virtual_disk_type = "thin"
}

# Create VM
resource "esxi_guest" "pxe-server" {
  guest_name = "pxe-server"
  disk_store = var.datastore
  boot_disk_type = "thin"
  boot_disk_size = 100
  guest_startup_timeout = "60"
  guestos = "rhel7-64"
  notes = "PXE-Server per terraform konfiguriert"
  virthwver = 13
  memsize = "2048"
  numvcpus = "2"
  network_interfaces {
    virtual_network = "VM Network"
    nic_type = "vmxnet3"
  }
  power = "off"
  virtual_disks {
    virtual_disk_id = esxi_virtual_disk.additional01.id
    slot = "0:1"
  }
}

