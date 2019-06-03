# Modul 300 - DIESDASANANAS

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

WICHTIG: Ubuntu Webserver konnte nicht hinzugefügt werden (Zeitgründe)

    +------------------------------------------------------------------------------------+   
    |NAT Netzwerk 10.0.2.0/24                                                            |   
    |                                                                                    |   
    |                                                                                    |   
    |                                                                                    |   
    |+---------------------------+ +--------------------+ +-----------------------------+|   
    ||Hostname: web01            | | Hostname: db01     | |Hostname: master             ||   
    ||                           | |                    | |                             ||   
    ||eth0: NAT (DHCP)           | |eth0: NAT (DHCP)    | |eth0: NAT (DHCP)             ||   
    ||Ports: 80, 443 (any to any)| |OS: CentOS/7        | |Ports: 80, 443 (web01 to any)||  
    ||OS: Ubuntu/trusty64        | |                    | |OS: CentOS/7                 ||   
    |+---------------------------+ +--------------------+ +-----------------------------+|   
    +------------------------------------------------------------------------------------+   


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



## Sicherheit implementieren <a name="k4"></a>
> [⇧ **Nach oben**](#inhaltsverzeichnis)

### Firewall Konfigurationen

#### CentOS

1. Firewall aktivieren & enablen
```
systemctl start firewalld
systemctl enable firewalld
```

2. Firewall Rules setzen
```
sudo firewall-cmd --permanent --add-port=22/tcp
sudo firewall-cmd --permanent --add-port=22/udp
sudo firewall-cmd --permanent --add-port=80
sudo firewall-cmd --permanent --add-port=443
```

3. Firewall-Reload ausführen
```
sudo firewall-cmd --reload
```

#### Ubuntu

```
#activate firewall
sudo apt-get install ufw -y
yes | sudo ufw enable

#set firewall rules
sudo ufw deny out to any
sudo ufw allow 22
sudo ufw allow 80/tcp
sudo ufw allow 80/udp
sudo ufw allow 443/tcp
sudo ufw allow 443/udp
```

<br>
### Reverse Proxy

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

## Zusätzliche Bewertungspunkte <a name="k5"></a>
> [⇧ **Nach oben**](#inhaltsverzeichnis)

### Reflexion
