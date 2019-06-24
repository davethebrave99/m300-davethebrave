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

dann vagrant up

docker run -d -name ghost_mysql -p 3306 mysql:5.7 -e MYSQL_ROOT_PASSWORD=barth -e MYSQL_USER=ghost MYSQL_PASSWORD=barth -e MYSQL_DATABASE=ghost --restart=always

docker run -d -name ghost ghost:2.25.1-alpine --link ghost




### Volumes zur persistenten Datenablage eingerichtet








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

### Aktive Benachrichtigung ist eingerichtet

### Drei Aspekte der Container



## Zusätzliche Bewertungspunkte (Allgemein)

### Übungsdokumentation als Vorlage für Modul-Unterlagen erstellt

### Vergleich Vorwissen - Wissenszuwachs

### Reflexion



## Zusätzliche, systemtechnische Bewertungspunkte