# Benutzerhandbuch

## Anleitung

Diese Automatisierung kann in der Testumgebung zu Hause dazu verwendet werden, um innerhalb kurzer Zeit eine schnelle Test-VM zu erstellen. Dazu müssen die folgenden Befehle ausgeführt werden.

## Schnell eine virtuelle Maschine zu Hause bereitstellen (ca. 3 Minuten)

```bash
# Login via SSH auf terraform-VM & Pfad festlegen
ssh terraform.home.local
mypath=$(pwd)

# Ordner erstellen
mkdir $mypath/git && cd $mypath/git

# Repository clonen
git clone https://github.com/Patthecat249/pxe-server.git

# VM erstellen
# Beispiele:
# VM erstellen: interaktiv (nur Hostname nach Aufforderung) vergeben
cd $mypath/git/pxe-server/playbooks && ansible-playbook 11_create_vm_from_clone.yaml

# VM erstellen: "Hostname" festlegen
cd $mypath/git/pxe-server/playbooks && ansible-playbook 11_create_vm_from_clone.yaml -e "hostname=patrick01"

# VM erstellen: Hostname, CPU & RAM festlegen
cd $mypath/git/pxe-server/playbooks && ansible-playbook 11_create_vm_from_clone.yaml -e "hostname=patrick01 cpu=4 ram=8192"
```

## Voraussetzungen

- VMware 6.7 mit vCenter 6.7
- Linux-VM als terraform & ansible host
- selinux disabled
- terraform v0.12.24
- ansible 2.9.7
- VM-template mit UUID (4226b890-4986-d6b5-f3ef-e3458f22cfee)



## Dokumentation

### VMware

- VMware ESXi-Host mit VMware ESXi 6.7 u3 ist installiert auf ESX02 (Lenovo SR650 mit 10xCores, 96GB RAM, ca 6TB Storage)
  - esx02.home.local - 10.0.249.11/24
- vCenter 6.7 ist installiert 
  - vcenter.home.local - 10.0.249.205/24



### DNS

- DNS läuft auf Rasperry Pi v3
  - pi.home.local - 10.0.249.53
- Domain:
  - home.local

### Netzwerk

- Subnet: 10.0.249.0/24
- Gateway: 10.0.249.1
- DNS: 10.0.249.53
- DHCP: yes, enabled



### Default-Account (User / Password) - VM

- user: root

- pass: Test1234



### Betriebssystem / VM-Template

Als **Betriebssystem** ist `CentOS 7.6` installiert. Die virtuelle VM wird aus einen VMware-Template `default-template` erzeugt, welches bereits im **Ordner** `Spielwiese` abgelegt ist. Im Terraform-Template ist die **UUID** `4226b890-4986-d6b5-f3ef-e3458f22cfee` des VM-Templates hart codiert.  