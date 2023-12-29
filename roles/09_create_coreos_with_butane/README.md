
# Install coreos on disk
```bash
root@coreos:~# coreos-installer install -I http://10.0.249.155/autologin.ign --insecure-ignition -n /dev/sda
Installing Fedora CoreOS 39.20231119.3.0 x86_64 (512-byte sectors)
> Read disk 2.4 GiB/2.4 GiB (100%)
Writing Ignition config
Copying networking configuration from /etc/NetworkManager/system-connections/
Copying /etc/NetworkManager/system-connections/ens33.nmconnection to installed system
Install complete.
root@coreos:~# reboot
```

## Simple butane-file
```bash
variant: fcos
version: 1.4.0
passwd:
  users:
    - name: core
      ssh_authorized_keys:
        - "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDbwtcFEfty86gZxv/59he46gusMu+Nh+2YIIlU5Z/ROi6zb4u7ySLkNbdouVh5cGcrtySe2WoG5xxLrat8uT87x40glmivDi3UCQsL5+3MDCVlcj6rMTbtehvcIqub9ZUnVGrD50d8eQUAtgYo1FGbL1fXRmmFXorBr3bb6hk+UyYrfcmxNGsCksGm5k+AN4j126fN+Q3rWu7zg7vhp9K1FsYXC/19AzuU5YWGCoa2nRwZ89xRgEmIyk0wKNlO44DWieNr6G9pM+WRLrkByAm03yFKWt2sKB6lolKkKy0DWENc0Ik/OGJIhzuJAuz6A5mfNhJucHHjoRJThEmVzJxPcWQkeBTUN4hRr1kOiUezaC33gNNvvmAT/w5idCqX+LF8eM4wePgOvL/L29LanA0ZWgmzZZMUcL530Uo/FO4I2d8ynvDlUlhKVbDGVTu2Hf7KY1sSWPgWl3x4GB9pBJBo5FVr9uUKted27cKme9BAWSFTR9VB1FI+g5FDQ+02QCc= root@fedora35"
systemd:
  units:
    - name: serial-getty@ttyS0.service
      dropins:
      - name: autologin-core.conf
        contents: |
          [Service]
          # Override Execstart in main unit
          ExecStart=
          # Add new Execstart with `-` prefix to ignore failure`
          ExecStart=-/usr/sbin/agetty --autologin core --noclear %I $TERM
storage:
  links:
    - path: /etc/localtime
      target: ../usr/share/zoneinfo/Europe/Berlin
  files:
    - path: /etc/vconsole.conf
      mode: 0644
      contents:
        inline: KEYMAP=de
    - path: /etc/NetworkManager/system-connections/ens33.nmconnection
      mode: 0600
      contents:
        inline: |
          [connection]
          id=ens33
          type=ethernet
          interface-name=ens33
          [ipv4]
          address1=10.0.249.250/24,10.0.249.1
          dhcp-hostname=coreos
          dns=10.0.249.53;8.8.8.8
          dns-search=home.local
          may-fail=false
          method=manual
    - path: /etc/hostname
      mode: 0644
      contents:
        inline: |
          coreos
    - path: /etc/profile.d/systemd-pager.sh
      mode: 0644
      contents:
        inline: |
          # Tell systemd to not use a pager when printing information
          export SYSTEMD_PAGER=cat
```

Role Name
=========

A brief description of the role goes here.

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
