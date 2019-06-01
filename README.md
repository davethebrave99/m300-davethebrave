# Modul 300 - DIESDASANANAS

In dieser Dokumentation weise ich die einzelnen Kompetenzen für die verschiedenen Lernbeurteilungen nach

## Inhaltsverzeichnis

* 01 - [Toolumgebung aufsetzen](#k1)
* K2 - [Lernumgebung einrichten](#k2)
* K3 - [Vagrant Vertiefung](#k3)
* K4 - [Sicherheit implementieren](#k4)
* K5 - [Zusätzliche Bewertungspunkte](#k5)

## Toolumgebung aufsetzen <a name="k1"></a>
> [⇧ **Nach oben**](#inhaltsverzeichnis)



## Lernumgebung einrichten <a name="k2"></a>
> [⇧ **Nach oben**](#inhaltsverzeichnis)


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
| vagrant init | erstellt Vagrantfile |
| vagrant up | erstellt eine VM mithilfe des Vagrantfiles | 
| vagrant ssh [VMName] | SSH-Verbindung zur Vagrant-VM |
| vagrant halt [VMNAME] | fährt die Vagrant-VM herunter |
| vagrant destroy | fährt die Vagrant VM herunter & zerstört diese anschliessen |

## Sicherheit implementieren <a name="k4"></a>
> [⇧ **Nach oben**](#inhaltsverzeichnis)

<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

## Zusätzliche Bewertungspunkte <a name="k5"></a>
> [⇧ **Nach oben**](#inhaltsverzeichnis)

<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
