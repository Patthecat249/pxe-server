# Bootstrapping of a PXE/TFTP-Server
- Create a vm (Minimal Installation of Rocky Linux, Fedora, CentOS or RHEL). This will be your pxe-server Tested with Rocky Linux 8.7
- Download the git repo on your bastion-host
- Configure the vars-files as it fits your needs
This contains some ansible-scripts to setup a pxe-server.


# General
This describes the installation and configuration of a simple PXE-Server based on DNSMASQ. Not DNS and/or DHCP! Only the part of PXE/TFTP. It describes how to configure the central */etc/dnsmasq.conf*. Which software yum have to download, and what you need, to provide ISO-Images, Initram-Disk, Boot-Kernel.


If you want to learn more about the whole process of pxe/tftp/dns and dhcp., you have to take a look in the project "pxe-environment". It it also based on DNSMASQ.


## Requirements
- You need a installed vm (e.q. Rocky-Linux, Fedora, CentOS or RHEL)
- You need a linux terminal with internet access to get the repository
- You must have a DHCP and DNS-Server up and running. I use DNSMASQ which runs on a second vm. It's DHCP-Option-66 points to your new pxe-server
```bash
# in DNSMASQ you can use the following line to tell new VMs the information, where your pxe-server is running
dhcp-option=66,pxe-server

# PXE-Server-Konfiguration which use the ISOLINUX standard pxelinux.cfg
dhcp-boot=pxelinux.0,pxe-server,pxe-server

# For UEFI-Boot Machines
# if your machines boot with UEFI-BIOS, use the shim-bootloader
dhcp-boot=tag:efi-x86_64,shimx64.efi,pxe-server,pxe-server

# Or enable the option to promt "F8" to offer your vm some options to interactive install the OS
pxe-prompt="Press F8 for menu.", 5
pxe-service=x86PC,"Choose and Install OS per TFTP from PXE-SERVER",pxelinux,pxe-server
```

- physical or virtual machine (tested and works on VMware 6.7u2)
- Tested on **CentOS 7.6 and RHEL 7.6** (the configuration is the same) - ***Minimal*** installation
- an **IPv4**-address for your PXE-Server

## Install packages
Your pxe-server needs the following software-packages.

- dnsmasq
- tftp
- syslinux

```bash
yum install -y dnsmasq tftp syslinux
```



## Central configuration-file *dnsmasq.conf*

The pxe-server configuration is very <u>easy</u> and <u>simple</u>. It contains only these three lines.

- **interface** = this is the network-interface name of your nic, which provides the content in your network
- **enable-tftp** = this enables the function of  a TFTP-Server and needs the option *tftp-root*
- **tftp-root** = this is the root-directory of your tftp-server. this folder should have at least read-and execute-rights for everybody. ('0755')

```bash
# /etc/dnsmasq.conf
interface=ens160,lo
enable-tftp
tftp-root=/home/tftproot/rootdir/tftpboot
```



