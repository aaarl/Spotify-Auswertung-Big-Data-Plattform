# Spotify-Auswertung-Big-Data-Plattform

Big-Data-Anwendung zur Auswertung und Analyse der Spotify-Datensätze.

# Links to use:

https://rogerdudler.github.io/git-guide/index.de.html

## TODO

#### Reminder: Dieses Feld muss vor Release des Projekts entfernt werden - Dient nur der Organisation und Abstimmung

## Use Cases

- **Spotify: beliebte Lieder über Dashboard darstellen**
- ~~US-Wahl mit Verteilung einzelner Regionen~~
- ~~Corona: Infektionszahlen~~
- ~~Wildschweinabschüsse: Afrikanische Schweinepest~~
- ~~Häufigste Krankheiten: WHO Daten~~

## TODO-Liste:

|       Status       | Bearbeiter | Aufgabe                                                                 |
| :----------------: | :--------: | :---------------------------------------------------------------------- |
| :white_check_mark: | Arl        | Git-Repo erstellen                                                      |
| :white_check_mark: | Alle       | Gedanken zum Result machen (z.B. Zähler: wie oft wurde das Lied gehört) |
| :white_check_mark: | Arl        | README-Datei erstellen                                                  |
| :white_check_mark: | Arl        | Erste Gedanken zur Architektur                                          |
| :white_check_mark: | Arl        | License file anlegen                                                    |
| :white_check_mark: | Arl        | Grobe Aufgabenverteilung überlegen                                      |
| :white_check_mark: | Arl        | Allen Git erklären und Umgebung einrichten                              |
|                    |            |                                                                         |
| :white_check_mark: | Max        | CSV-Datei erstellen                                                     |
| TODO               | Arl        | MySQL-Workbench aufsetzen                                               |
| :white_check_mark: | Arl        | Review CSV-Datei                                                        |
| :white_check_mark: | Arl        | Anpassung der CSV-Datei (Lesbarkeit und Konstanz)                       |
| :white_check_mark: | Arl        | Erste Shell-Befehle zum Starten der Cluster, Container etc.             |
| :white_check_mark: | Arl        | Auflistung aller offenen Tasks/ Aufgaben anlegen                        |


## Offene Aufgaben:

| Aufgabe                          | Status | Bearbeiter |
| :------------------------------- | :----: | :--------: |
| **src > app > database**         |        |            |
| spotify.mwb                      | TODO   | Arl        |
| init-sample.sql                  | TODO   | Arl        |
| init.sql                         | TODO   | Arl        |
| **src > hdfs**                   |        |            |
| ~~deleteHDFS.sh~~                | DONE   | Arl        |
| ~~extractHDFS.sh~~               | DONE   | Arl        |
| ~~startHDFS.sh~~                 | DONE   | Arl        |
| startLoad.sh                     | TODO   | Arl        |
| **src > data**                   |        |            |
| ~~Dockerfile~~                   | DONE   | Arl        |
| ~~deleteAllSparkpods.sh~~        | DONE   | Arl        |
| kafkaSql.jar                     | TODO   | Arl        |
| mysql.jar                        | TODO   | Arl        |
| ~~setup.md~~                     | DONE   | Arl        |
| ~~startSpark.sh~~                | CHECK  | Arl        |
| updateScript.sh                  | CHECK  | necessary? |
| uploadData.sh                    | CHECK  | necessary? |
| **src > data > batch**           |        |            |
| ~~submit.sh~~                    | DONE   | Arl        |
| ~~testingData.py~~               | DONE   | Arl        |
| ~~writeToDatabase.py~~           | DONE   | Arl        |
| **src > data > kafka**           |        |            |
| ~~startKafka.sh~~                | DONE   | Arl        |
| ~~deleteKafka.sh~~               | DONE   | Arl        |
| ~~kafka-cluster-def.yml~~        | DONE   | Arl        |
| ~~kafka-topic_web-requests.yml~~ | DONE   | Arl        |
| **src > data > streaming**       |        |            |
| ~~kafkaStreaming.py~~            | DONE   | Arl        |
| ~~sparkStreaming.py~~            | DONE   | Arl        |
| ~~startStreaming.sh~~            | DONE   | Arl        |
| ~~submitKafka.sh~~               | DONE   | Arl        |
| ~~submitStreaming.sh~~           | DONE   | Arl        |

### Notizen zu den offenen Aufgaben:

Folgende Baustellen sind aktuell noch zu erledigen:

- Skripte für HDFS (~~Starten~~, Laden (Arl), Löschen)
- ~~TODO AF: Skripte für Kafka (Starten und Löschen inkl. beider .yaml-Dateien)~~
- ~~TODO Sven: Alle "artist" Namen in sparkStreaming.py eintragen (entsprechende Stelle ist im Code kommentiert)~~
- ~~TODO Sven: Unterschiede zwischen dem Ordner "collection" und "test" ermitteln und auf "collection" reduzieren (test sollte nicht mehr hier sein)~~
- **TODO Arl:** Überprüfen ob wir einen Update-Case haben bzw. benötigen (aktuelle Datensätze)
  - entsprechende Skripte überprüfen
- **TODO Arl:** Fertigstellen der MySQL-Workbench und der entsprechenden Skripte + .jar-Dateien
  - startSpark.sh überprüfen bzgl. Updates

## Fragen:

- Dummy Daten aus einer fiktiven SQL-Datenbank?!
- Soll Dashboard elastisch sein?

## Abgabedatum:

Beratungstermin: **10.11.2020 um 17:00 Uhr** <br/>
Projektabgabe: **23.12.2020**

## Beschreibung des Projekts

TODO Alle

## Konzept

TODO AF

### Architektur

TODO AF

## Dokumentation

TODO AF

## Aufbau der Datenbank

TODO AF

### Interaktion mit der Datenbank

TODO AF

## Code-Implementierung und Architektur

TODO AF

## Anwendung

TODO AF
