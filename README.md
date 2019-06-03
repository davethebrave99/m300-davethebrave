# Modul 300 - Plattformübergreifende Dienste in ein Netzwerk integrieren

In dieser Dokumentation weise ich die einzelnen Kompetenzen für die verschiedenen Lernbeurteilungen nach

## Inhaltsverzeichnis

* K1 - [Toolumgebung aufsetzen](#k1)
* K2 - [Lernumgebung einrichten](#k2)
* K3 - [Vagrant Vertiefung](#k3)
* K4 - [Sicherheit implementieren](#k4)
* K5 - [Zusätzliche Bewertungspunkte](#k5)

## Toolumgebung aufsetzen <a name="k1"></a>
> [⇧ **Nach oben**](#inhaltsverzeichnis)

Keine notwendigen Schritte, welche man dokumentieren hätte müssen

## Lernumgebung einrichten <a name="k2"></a>
> [⇧ **Nach oben**](#inhaltsverzeichnis)

### Mit Git Repository pushen (Git Client wurde verwendet)

1. Als erstes geht man in den Master des Repositories

2. Danach fügt man den neuen Content mit dem folgenden Befehl hinzu

3. Als nächstes führt man einen Commit aus und gibt an, was geändert wurde

4. Zu guter letzt pusht man das Repository in die Cloud (Git)


## Vagrant Vertiefung <a name="k3"></a>
> [⇧ **Nach oben**](#inhaltsverzeichnis)

### Bestehende vm aus Vagrant-Cloud einrichten
***

1. Auf den "Clone or download" Button klicken und den Link zum klonen via HTTPS oder SSH kopieren

![link profile picture](./images/k3/k3_01.png "Title")

2. Clone-Befehl ausführen
```
    git clone https://github.com/mc-b/M300.git
```
3. Nun kann eine beliebige VM aus dem Repository ausgewählt und gestartet werden
```
    cd M300/vagrant/db/ && vagrant up
```
4. Auf diese VM kann nun mit ssh zugreifen
```
    vagrant ssh
```

### Kennt die Vagrant Befehle
***

In diesem Abschnitt sind einige Vagrant Befehle welche beim Benutzen von Vagrant oft gebraucht werden.

| Befehl | Funktion |
| ----- | ----- |
| vagrant box list | Zeigt eine Liste aller Vagrant-Boxen welche in der Vagrant-Umgebung vorhanden sind |
| vagrant box add [OS/ARCHITECTURE] | Fügt eine Vagrant-Box aus der Vagrant-Cloud hinzu |
| vagrant init [OS/ARCHITECTURE] | erstellt Vagrantfile |
| vagrant up | erstellt eine VM mithilfe des Vagrantfiles | 
| vagrant ssh [VMName] | SSH-Verbindung zur Vagrant-VM |
| vagrant halt [VMNAME] | fährt die Vagrant-VM herunter |
| vagrant destroy | fährt die Vagrant VM herunter & zerstört diese anschliessen |

### Andere, vorgefertigte VM auf eigenem Notebook aufgesetzt
***

1. Ein Directory für die neue Vagrant VM erstellen
```
mkdir Vagrant_CENTOS
```
```
cd Vagrant_CENTOS
```

2. Die bereits vorhandenen Boxen in der Vagrant-Umgebung überprüfen
```
vagrant box list
```

3. Falls die CentOS 7 Box noch nicht hinzugefügt wurde...
```
vagrant box add centos/7
```

4. Vagrantfile für die CentOS 7 Box erstellen & Box starten
```
vagrant init centos/7
```
```
vagrant up
```



### VMs mit eigenem Vagrantfile aufsetzen
***

In diesem Abschnitt dokumentiere ich die Arbeit an meiner eigenen VM-Umgebung. Ich möchte mit einem Vagrantfile mehrere VMs erzeugen, welche auch miteinander kommunizieren könnenn (siehe Abschnitt Netzwerkplan weiter unten).

1. Wir gehen in das eigene Repository von M300
```
cd ./m300-davethebrave/
```

2. Als nächstes erstellt man ein Vagrantfile und spezifiziert das Betriebssystem
```
vagrant init centos/7
```

#### Vagrantfile

Als nächstes geht es darum das Vagranfile zu modifizieren. Dieses finden Sie im Repostiory unter dem standardmässigen Namen (Vagrantfile). Ich füge dieses hier aus Übersichtsgründen nicht ein sondern kommentiere lediglich die einzelnen Parameter aus.

Dies steht am Anfang des Vagrantfiles und definiert den Anfang der Konfigurationsdatei. Beendet wird diese Schlaufe mit dem "end" Parameter".
```
Vagrant.configure("2") do |config|
```
<br>

Diese Linie definiert eine einzelne virtuelle Maschine. In diesem Falle wäre das die virtuelle Maschine "web01".
```
config.vm.define "web01" do |web01|
```
<br>

Die Parameter welche folgen beginnen grösstenteils mit web01(Variable für die VM).vm(Angabe dass es sich um eine VM handelt).[Individueller Parameter]
<br>
Dieser Parameter bestimmt den Hostnamen
```
web01.vm.hostname = "web01"
```
<br>

Mit dem Parameter Network können wir die freigegebenen Ports von Host zu Gast bestimmen. In diesem Falle erlauben wir jeglichen HTTP/HTTPS-Traffic.
```
web01.vm.network "forwarded_port", guest:80, host:8080, auto_correct: true
web01.vm.network "forwarded_port", guest:443, host:4343, auto_correct: true
```
<br>

Standardmässig wird bei jeder Vagrant-VM ein NAT-Adapter eingerichtet. Wenn man möchte kann man noch mithilfe des Network-Parameters zusätzliche Netzwerkadapter einrichten. In meinem Falle habe ich für jede VM noch ein privates Netz mit einer IP-Adresse der Klasse C eingerichtet (192.168.1.XXX/24). Somit können die virtuellen Maschinen auch untereinander kommunizieren.
```
web01.vm.network "private_network", ip: "192.168.1.10"
```
<br>

Mit dem Provider-Parameter können wir den Namen & Memory angeben, welcher der VM-Provider (in unserem Falle VirtualBox) der virtuellen Maschine gibt.
```
web01.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
    vb.name = "web01"
end
```
<br>

Mit dem Provision-Parameter können verschiedene Arten gewählt werden die VM weiter zu konfigurieren. In meinem Falle verweise ich auf ein Shell-Skript, welches ebenfalls in diesem Repository zu finden ist.
```
web01.vm.provision "shell", path: "web01.sh"
```
<br>

Zu guter Letzt beendet man die Konfiguration dieser VM mit "end".
```
end
```

### Netzwerkplan

WICHTIG: Der Webserver kann nur über die private IP-Adresse erreicht werden

    +---------------------------------------------------------------+                                                                       
    | Privates Netzwerk 192.168.1.0/24                              |                                                                       
    | Zusätzlich pro VM 1x NAT Verbindung von Gast zu Host          |                                                                       
    |                                                               |                                                                       
    |                                                               |                                                                       
    | +---------------------------+  +----------------------------+ |                                                                       
    | |Hostname: ws01             |  | Hostname: web01            | |                                                                       
    | |                           |  |                            | |                                                                       
    | |eth0: NAT (DHCP)           |  | enp0s3: NAT (DHCP)         | |                                                                       
    | |eth1: 192.168.1.10/24      |  | enp0s8: 192.168.1.30/24    | |                                                                       
    | |Ports: 80, 443 (any to any)|  | Ports: 80, 443 (any to any)| |                                                                       
    | |OS: CentOS/7               |  | OS: Ubuntu/trusty64        | |                                                                       
    | +---------------------------+  +----------------------------+ |                                                                       
    | +-----------------------------+ +---------------------------+ |                                                                       
    | |Hostname: master             | |Hostname: db01             | |                                                                       
    | |                             | |                           | |                                                                       
    | |eth0: NAT (DHCP)             | |eth0: NAT (DHCP)           | |                                                                       
    | |eth1: 192.168.1.20/24        | |eth1: 192.168.1.40/24      | |                                                                       
    | |Ports: 80, 443 (web01 to any)| |Ports: 3306 (any to any)   | |                                                                       
    | |OS: CentOS/7                 | |OS: CentOS/7               | |                                                                       
    | +-----------------------------+ +---------------------------+ |                                                                       
    +---------------------------------------------------------------+


### Testfälle
***

In diesem Abschnitt werden verschiedene Test-Cases durchgeführt.
<br>

```
vagrant ssh
```
<br>

1. Wurde das richtige OS installiert?
```
hostnamectl --> Zeigt unter anderem installiertes OS an
```

2. Läuft der Webserver?
```
systemctl status httpd
```

3. Ist SELinux disabled?
```
sestatus --> Zeigt den Status von SELinux an
```

4. Läuft die Firewall? (CentOS)
```
systemctl status firewalld
```

5. Läuft die Firewall? (Ubuntu)
```
sudo ufw status
```

6. Wurden die Benutzer erstellt?
```
su [USERNAME]
cat /etc/passwd --> Zeigt alle Benutzer im System
```



## Sicherheitsaspekte sind implementiert <a name="k4"></a>
> [⇧ **Nach oben**](#inhaltsverzeichnis)

### Firewall Konfigurationen

#### Generelles Aktivieren der Firewall
##### Ubuntu-Hosts


Firewall aktivieren/enablen
```
yes | sudo ufw enable
```

Firewall reloaden
```
sudo ufw reload
```
<br>

##### CentOS7-Hosts

Firewall aktivieren
```
systemctl start firewalld
```

Firewall enablen
```
systemctl enable firewalld
```

Firewall reloaden
```
firewall-cmd --reload
```
<br>

#### Config: master-Host
```
#set firewall rules
sudo firewall-cmd --permanent --add-port=22/tcp
sudo firewall-cmd --permanent --add-port=22/udp

#set firewall rules for http
sudo firewall-cmd --permanent --zone=public --add-rich-rule='
  rule family="ipv4"
  source address="10.0.2.1/32"
  port protocol="tcp" port="80" accept'

#set firewall rules for https
sudo firewall-cmd --permanent --zone=public --add-rich-rule='
  rule family="ipv4"
  source address="10.0.2.1/32"
  port protocol="tcp" port="443" accept'
```
<br>

#### Config: ws01-Host
```
sudo firewall-cmd --permanent --add-port=22/tcp
sudo firewall-cmd --permanent --add-port=22/udp
sudo firewall-cmd --permanent --add-port=80/tcp
sudo firewall-cmd --permanent --add-port=443/tcp
```

#### Config: web01-Host
```
sudo ufw deny out to any
sudo ufw allow 22
sudo ufw allow 80/tcp
sudo ufw allow 80/udp
sudo ufw allow 443/tcp
sudo ufw allow 443/udp
```

#### Config: db01-Host
```
sudo firewall-cmd --permanent --add-port=22
sudo firewall-cmd --permanent --add-port=3306
```
<br>

### Reverse Proxy einrichten

1. Notwendige Pakete installieren
```
sudo apt-get install libapache2-mod-proxy-html
sudo apt-get install libxml2-dev
```

2. Plugins aktivieren
```
sudo a2enmod proxy
sudo a2enmod proxy_html
sudo a2enmod proxy_http
```

3. Die Datei /etc/apache2/apache2.conf ergänzen
```
web01ubuntu localhost 
```

4. Apache-Webserver neu starten:
```
sudo service apache2 restart
```

5. sites-enabled/001-reverseproxy.conf ergänzen
```
Allgemeine Proxy Einstellungen
    ProxyRequests Off
    <Proxy *>
        Order deny,allow
        Allow from all
    </Proxy>

     Weiterleitungen master
    ProxyPass /master http://master
    ProxyPassReverse /master http://master
```

### User-Passwort

Um die virtuellen Mashcinen besser zu schützen empfiehlt es sich das Standardpasswort vom Benutzer vagrant zu ändern. Dies kann im Provisioning-Shellscript getan werden.
```
sudo echo "complexpassword" | passwd --stdin vagrant
```

### Ngrok Tunnel erstellen

Da ich diesen Schritt

1. Ngrok herunterladen & Archiv entpacken 
```
wget -qO- https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip | tar xvz -
```

2. Als nächstes muss man einen eigenen Auth-Token erstellen. Diesen bekommt man wenn man sich unter https://dashboard.ngrok.com/login registriert.

3. Hat man seinen Auth-Token generiert führt man im entpackten Archiv den folgenden Befehl aus.
```
./ngrok authtoken <YOUR_AUTH_TOKEN>
```

Nun sieht man die offenen Tunnels. Um einen neuen Tunnel zu öffnen führt man einfach einen der unten stehenden Befehle aus.
```
./ngrok http 80 --> HTTP Tunnel starten
```
```
./ngrok http 22 --> SSH Tunnel starten
```

## Zusätzliche Bewertungspunkte <a name="k5"></a>
> [⇧ **Nach oben**](#inhaltsverzeichnis)

### Reflexion

Ich konnte mich in diesem Projekt in folgenden Punkten verbessern
* Linux-Services wie Apache, MySQL etc.
* Shell-Scripts
* Allgemeine Linux-Befehle
* Umgang mit der Linux CLI

Ich habe zuvor noch nie mit Vagrant gearbeitet und habe deshalb mit dieser LB sehr viel neues gelernt.
Ich konnte zudem meine Kenntnisse in Linux (Ubuntu und CentOS) sowie dem Skripten mit Bash erweitern.

Die Arbeit mit Vagrant hat mir Spass gemacht und war sicherlich eine gute Vorbereitung auf die LB3 mit Docker & Kubernets.