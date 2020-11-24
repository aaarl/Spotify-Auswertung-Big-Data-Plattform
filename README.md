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

| Aufgabe                      | Status | Bearbeiter |
| :--------------------------: | :----: | :--------- |
| **src > app > database**     |        |            |
| spotify.mwb                  | TODO   | Arl        |
| init-sample.sql              | TODO   | (Arl)      |
| init.sql                     | TODO   | (Arl)      |
| **src > hdfs**               |        |            |
| deleteHDFS.sh                | TODO   | -          |
| extractHDFS.sh               | TODO   | -          |
| startHDFS.sh                 | TODO   | -          |
| startLoad.sh                 | TODO   | -          |
| **src | data**               |        |            |
| Dockerfile                   | TODO   | Arl        |
| deleteAllSparkpods.sh        | TODO   | -          |
| kafkaSql.jar                 | TODO   | Arl        |
| mysql.jar                    | TODO   | Arl        |
| setup.md                     | TODO   | Arl        |
| startSpark.sh                | TODO   | -          |
| updateScript.sh              | TODO   | -          |
| uploadData.sh                | TODO   | necessary? |
| **src > data > batch**       |        |            |
| submit.sh                    | TODO   | -          |
| testingData.py               | TODO   | Arl        |
| writeToDatabase.py           | DONE   | Arl        |
| **src > data > kafka**       |        |            |
| startKafka.sh                | TODO   | -          |
| deleteKafka.sh               | TODO   | -          |
| kafka-cluster-def.yml        | TODO   | - (1)      |
| kafka-topic_web-requests.yml | TODO   | - (2)      |
| **src > data > streaming**   |        |            |
| kafkaStreaming.py            | TODO   | Arl        |
| sparkStreaming.py            | TODO   | Arl        |
| startStreaming.sh            | TODO   | -          |
| submitKafka.sh               | TODO   | -          |
| submitStreaming.sh           | TODO   | -          |

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
