# Bootstrapping of a PXE/TFTP-Server
This contains some ansible-scripts to setup a pxe-server.

Not DNS/DHCP! Only PXE/TFTP.

# General

This describes the installation and configuration of a simple PXE-Server based on DNSMASQ. It describes how to configure the central */etc/dnsmasq.conf*. Which software yum have to download, and what you need, to provide ISO-Images, Initram-Disk, Boot-Kernel.



If you want to learn more about the whole process of pxe/tftp/dns and dhcp., you have to take a look in the project "pxe-environment". It it also based on DNSMASQ.



## Requirements

- physical or virtual machine (tested and works on VMware 6.7u2)
- Tested on **CentOS 7.6 and RHEL 7.6** (the configuration is the same) - ***Minimal*** installation
- an **IPv4**-address for your PXE-Server
- 



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



