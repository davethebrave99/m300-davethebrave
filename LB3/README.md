# Modul 300 - Plattformübergreifende Dienste in ein Netzwerk integrieren

In dieser Dokumentation weise ich die einzelnen Kompetenzen für die Lerbeurteilung 3 nach.

WICHTIGE INFORMATIONEN IM VORAUS:
Ich habe immer eine Vagrant-VM erstellt, auf der ich dann die Docker-Container laufen lassen habe.

## Inhaltsverzeichnis

* K1 - [Toolumgebung aufsetzen](#k1)
* K2 - [Lernumgebung einrichten](#k2)
* K3 - [Vagrant Vertiefung](#k3)
* K4 - [Sicherheit implementieren](#k4)
* K5 - [Zusätzliche Bewertungspunkte](#k5)
* K6

## Toolumgebung aufsetzen

- [x] VirtualBox installiert
- [x] Vagrant installiert
- [x] Visualstudio-Code installiert
- [x] Git-Client installiert
- [x] SSH-Key für Client erstellt

## Lernumgebung einrichten

- [x] GitHub-Account ist erstellt
- [x] Git-Client wurde verwendet
- [x] Dokumentation ist als Markdown vorhanden
- [x] Markdown-Editor ausgewählt und eingerichtet (Visualstudio-Code) 

- [x] Persönlicher Wissensstand zu den wictigsten Themen ist dokumentiert:

### Persönlicher Wissensstand

Ich weiss in der Theorie wie Docker funktioniert und kann erklären wie es funktioniert (Abgeschottete Systeme welche sich von den Ressourcen des Host-Systemes bedienen etc.)
Ich habe in der Praxis vor diesem Modul noch NIE mit Docker gearbeitet und bin sehr gespannt was sich aus den Lektionen in diesem Modul ergeben wird.

### Containerisierung

Container sind "virtuelle Maschinen" welche sich die Ressourcen mit dem Host-Betriebssystem teilen und deshalb sehr wenig Bedarf an Speicherplatz haben.
Container sind leichtgewichtig und können in weniger als einer Sekunde gestartet werden.

Der Vorteil von Containern ist, dass sie von anderen Containern und Systemen auf dem Host-PC abgeschottet sind, weshalb sie überall gleich laufen.
Deshalb hat man dank Containern kein Problem mehr wo die Software zwar auf der Test & Staging Plattform problemlos läuft, jedoch genau auf der Prod-Plattform nicht.

Das Leben von Containern ist direkt an deren Hauptprozzess gebunden.
Dies bedeutet, dass wenn der Hauptprozzess beendet wird oder stirbt, der Container heruntergefahren wird.

### Docker

Docker ist eine Applikation um Container zu erstellen, zu verwalten, zu bedienen und zu löschen.

Man kann ein beliebiges Docker-Image von Dockerhub (https://hub.docker.com/) herunterladen und damit einen Container erstellen und direkt starten.
Oder man kann mithilfe eines "Dockerfiles" ein Image von Dockerhub herunterladen und dieses Image dann noch verändern.

Beispielsweise kann man Alpine Linux installieren und danach noch On-Top einen Webserver installieren. Das Dockerfile würde dann wie folgt aussehen:

```
FROM alpine:3.10.0
EXPOSE 80
RUN apk add apache2 && rc-service apache2 start
```

Aus diesem Dockerfile wird dann ein eigenes Image erzeugt, wo beim Start direkt der Webserver heruntergeladen & gestartet wird.
Dies ist ein sehr simples Dockerfile, die Möglichkeiten sind bei Docker weit umfangreicher.

### Microservices

"Microservices" ist der Begriff für einen Architekturstil in der Informatik.
Es geht dabei darum, dass man ein grosses System strukturiert und ganz klar in kleinere Services unterteilt.
So kann man dann ganz einfach kleinere Teams zusammenstellen, wobei jedes einzelne Team für einen Microservice zuständig ist.

Beispiel:
Bei Amazon könnte die Unterteilung in Microservices gemacht werden mit Bestellungsservice - Wunschliste - Zahlungsprozzessverarbeitung etc.

## (Eigene) Docker-Projekte
### Bestehende Docker-Container kombinieren / Bestehende Container als Backend, Desktop-App als Frontend einsetzen

Wir wollen als erstes zwei Docker-Container miteinander kombinieren. Dabei soll der eine Container ein Webfrontend mit Webserver enthalten, während der andere Container die Datenbank, also das Backend enthält.

Die nötigen Docker-Images können direkt beim Erstellen der VM heruntergeladen werden.
```
# Docker Provisioner
    config.vm.provision "docker" do |d|
      d.pull_images "mysql:8.0.16"
      d.pull_images "ghost:2.25.1-alpine"
```

Danach startet man die Vagrant-VM
```
vagrant up
```

Da wir die nötigen Docker-Images nun bereits beim Starten der Vagrant-VM heruntergeladen haben können wir direkt die beiden Docker-Container mit "docker run" starten.
```
docker run -d --name ghost_mysql -p 3306:3306 -p 8080:80 -e MYSQL_ROOT_PASSWORD=barth -e MYSQL_USER=ghost -e MYSQL_PASSWORD=barth -e MYSQL_DATABASE=ghost mysql:8.0.16 --restart-always

docker run -d --name ghost -p 2368:2368 --link ghost_mysql:mysql -e database_client=mysql -e database__connection__host=ghost_mysql -e database__connection__user=ghost -e database__connection__password=barth -e database__connection__database=ghost ghost:2.25.1-alpine --restart=always
```

Durch das öffnen der Ports mit dem "-p"-Parameter und dem Link vom "ghost_mysql"-Container zum "mysql"-Container sind die beiden Container miteinander verbunden und können miteinander kommunizieren.
Man kann diese Commands entweder über Bash ausführen oder direkt im Vagrantfile im Docker Provisioning, siehe weiter unten:
```
d.run "ghost_mysql", image: "mysql:5.7", args: "-e MYSQL_ROOT_PASSWORD=admin -e MYSQL_USER=ghost -e MYSQL_PASSWORD=secret -e MYSQL_DATABASE=ghost --restart=always"
d.run "ghost", image: "ghost:1-alpine", args: "--link ghost_mysql:mysql -e database__client=mysql -e database__connection__host=ghost_mysql -e database__connection__user=ghost -e database__connection__password=secret -e database__connection__database=ghost -p 2368:2368 --restart=always"
```

### Eigene Docker Container erstellen
Siehe Verzeichnis: **eigene_umgebung**

Ich habe eine Docker-Umgebung mit Vagrant eingerichtet, auf welcher sich ein Apache-Container und ein MYSQL-Container befindet. Beide Container können miteinander interagieren.

#### Vagrantfile
Ich werde die verschiedenen Abschnitte aus dem Vagrantfile erläutern. Aus Übersichtsgründen werde ich jedoch nicht das ganze Vagrantfile abbilden, dies kann auch so separat angeschaut werden.

Base-Image definiert
```
config.vm.box = "ubuntu/xenial64"
```

```
    config.vm.network "forwarded_port", guest:80, host:8080, auto_correct: true
    config.vm.network "forwarded_port", guest:8081, host:8081, auto_correct: true
    config.vm.network "forwarded_port", guest:8082, host:8082, auto_correct: true
    config.vm.network "forwarded_port", guest:3306, host:3306, auto_correct: true  
    for i in 32760..32780
      config.vm.network :forwarded_port, guest: i, host: i
    end
```

dann noch...
```
    config.vm.hostname = "docker"
    config.vm.network "private_network", ip:"192.168.60.101"
```
```
config.vm.provider "virtualbox" do |vb|
       vb.memory = "2048"
    end
```

sync this
```
    config.vm.synced_folder "shared_folder/", "/home/vagrant/shared_folder"
```

pull images
```
    config.vm.provision "docker" do |d|
      d.pull_images "mysql:8.0.16"
      d.pull_images "php:7.4.0alpha1-apache-stretch"
    end
```

#### In der Docker-VM
Nun wollen wir unsere Docker-Container starten

```
docker run
docker run
```

### Volumes zur persistenten Datenablage eingerichtet

Es gibt bei Docker verschiedene Arten Volumes zur dauerhaften Ablage von Daten zu erstellen.
Für meine Docker-Umgebung






### Kennt die Docker spezifischen Befehle
#### Befehle um Docker Container zu managen

| Befehl | Funktion |
| ----- | ----- |
| docker help | Zeigt eine Liste aller Vagrant-Boxen welche in der Vagrant-Umgebung vorhanden sind |
| docker --version | Zeigt eine Liste aller Vagrant-Boxen welche in der Vagrant-Umgebung vorhanden sind |
| docker stats | Fügt eine Vagrant-Box aus der Vagrant-Cloud hinzu |
| docker ps (-a) (-q) | erstellt Vagrantfile |
| docker images | erstellt eine VM mithilfe des Vagrantfiles | 
| docker push | SSH-Verbindung zur Vagrant-VM |
| docker pull | XXXXXXXXXXXXXXX |

#### Befehle um Docker Container zu 

Version checken
docker --version

Zeige live stream der container und welche ressourcen sie verbrauchen
docker stats

stoppe einen oder mehrere container
docker stop [NAME]

liste alle container auf
docker ps

alle gepullte docker images auflisten
docker images


Ein docker image auf ein repository pushen/von einem repository pullen
docker push/pull
--> vorher einloggen mit docker login



container enfernen
docker rm [CONTAINERNAME]

docker image entfernen
docker rmi [IMAGENAME]

ssh into containers
http://phase2.github.io/devtools/common-tasks/ssh-into-a-container/

### Netzwerkplan



### Testfälle

## Sicherheitsaspekte sind implementiert

- [x] Sicherheitsmassnahmen zur eigenen Umgebung sind dokumentiert
- [x] Projekt mit Git & Markdown dokumentiert

### Service-Überwachung ist eingerichtet
https://github.com/mc-b/M300/tree/master/35-Sicherheit

### Aktive Benachrichtigung ist eingerichtet

### Drei Aspekte der Container



## Zusätzliche Bewertungspunkte (Allgemein)

### Übungsdokumentation als Vorlage für Modul-Unterlagen erstellt

### Vergleich Vorwissen - Wissenszuwachs

### Reflexion



## Zusätzliche, systemtechnische Bewertungspunkte