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

## Einleitung:

In der Vorlesung “Data Science & Big Data” besteht die Prüfungsleistung aus zwei verschiedenen Laborberichten. Das Ziel der Gruppenaufgabe im Laborbericht 1 ist es, einen Applikation für einen Anwendungsfall zu entwickeln. Dieser soll  in der Vorlesung kennen gelernten Ziel-Architektur realisiert werden. 

Zu Beginn des Projekts wurde das Projektteam definiert und sich auf eine Projektdokumentation geeinigt. Als Versionsverwaltung des Software-Entwicklungsprojekts wurde sich auf GitHub festgelegt. Das tracken der Aufgaben innerhalb des Projekts erfolgte in der README-Datei des Repositorys. Die gruppeninterne Kommunikation erfolgt in einer WhatsApp-Gruppe.

## Identifikation des Use Cases

In einem per Videoschalte durchgeführten Workshop wurde der für eine Anwendungsfall für die Big Data Applikation erarbeitet. Als erstes wurden in einem Brainstorming fünf verschiedene Use Cases genannt. Diese wurden anschließend von den Projektmitgliedern ausformuliert.

| Nummer                           | Thema |
| :----: | :-------------------------------| 
|1 |Spotify Dashboard - Ausgabe von Hitlisten|
|2 |US-Wahl: Abstimmungsergebnisse in einzelnen Regionen darstellen|
|3 |Corona: Infektionszahlen in verschiedenen Landkreisen|
|4 |Afrikanische Schweinepest: Wildschweinabschüsse mit positiver Inzidenz|
|5 |Weltweit häufigste Krankheiten in einer Liste darstellen|


Nach einer sorgfältigen Erwägung des Fürs und Widers der jeweiligen Use Cases, wurde sich auf die Anwendung “Spotify Dashboard - Ausgabe von Hitlisten” festgelegt. Als vorteilhaft für diese Anwendung zeigten sich eine bereits große Menge an verfügbaren Daten, ein klares Zielbild der Applikation, sowie eine positive Assoziation mit dem Thema Musik.


# Konzept
Aufgabenstellung
Die zugrundeliegende Aufgabenstellung und die Rahmenbedingungen sind dem verlinkten PDF Dokument zu entnehmen.

## Ziel-Architektur
Im Rahmen der Vorlesung wurden zwei fundamentale Architekturmodelle zur möglichen Modellierung einer Big Data Science Plattform vertieft. Eine solche Architektur wird benötigt, um die Anforderungen an die Anwendung optimal lösen zu können. Zunächst werden die zwei Architekturen miteinander verglichen und anschließend eine Auswahl vorgenommen.

## Kappa-Architektur vs. Lambda-Architektur
### Lambda Architektur
Die Lambda Architektur wurde 2011 von Nathan Marz vorgestellt [1]. Die Besonderheit der Architektur liegt in der Aufteilung zwischen einem Batch und Speed Layer begründet. Im Batch Layer werden die eingehenden Rohdaten gespeichert und verarbeitet. Die Daten werden zunächst nicht prozessiert, sondern erst nach bestimmten Zeitabständen. Dabei können die Zeitfenster von einigen Stunden bis hin zu Wochen variieren. Die Prozessierung im Batch Layer wird auf allen bis dahin gesammelten Daten durchgeführt und kann daher einige Stunden in Anspruch nehmen. Das Ergebnis wird anschließend im Serving-Layer gespeichert. Um neu eintreffende Daten nicht erst im nächsten Batch Prozess abzuarbeiten, erfolgt die Verarbeitung dieser Daten im Speed Layer. Dieser prozessiert die Daten in Echtzeit und stellt eine Ergänzung der Batch-Ansicht dar. Zur Beschleunigung des Vorgangs wird oftmals auf die komplexeren und aufwändigeren Regeln zur Vorverarbeitung der Daten verzichtet. Das Ergebnis des Speed Layers wird ebenfalls im Serving-Layer gespeichert.

### Kappa-Architektur
Die Kappa Architektur wurde 2014 von Jay Kreps vorgestellt und stellt eine Vereinfachung der Lambda-Architektur dar [2]. Die Vereinfachung wird erreicht, indem der Batch Layer entfernt und alle Daten von dem Stream-Processing-Layer prozessiert werden. Die Speicherung des Ergebnisses erfolgt ebenfalls im Serving-Layer. Die Prozessierung von neuen Daten erfolgt durch den Start eines neuen Stream-Prozessing Prozesses. Sobald das neue Ergebnis vorliegt, wird der alte Stream-Processing Job gestoppt und die Ergebnisse werden gelöscht.

Vergleich der Architekturen
Beide Architekturen eignen sich nach wie vor zur Modellierung einer Big Data Science Plattform. Obwohl die Kappa-Architektur neuer ist und eine Vereinfachung darstellt, gibt es weiterhin Anwendungsfälle für die Lambda-Architektur. Eine Besonderheit der Kappa-Architektur ist, dass sich die Anwendungsfälle immer als ein Streamingproblem beschreiben lassen müssen.

Die im CSV-Format vorliegenden Spotify-Datensätze sollen allerdings nur täglich verarbeitet und aktualisiert werden. Aufgrund dessen, dass die Kappa-Architektur sich als Streamingproblem beschreiben lassen muss, wurde die Lambda-Architektur gewählt. Dadurch können Daten aus der CSV-Datei direkt vom Batch Layer bearbeitet und gleichzeitig eine Live-Analyse zu neuen Fällen, mithilfe des Speed Layers, durchgeführt werden.

Ein weiterer Punkt der für die Lambda Architektur spricht, liegt im Aufbau der Architektur begründet. Während die Kappa-Architektur lediglich aus dem Speed Layer besteht, werden bei der Lambda-Architektur der Batch und Speed Layer verwendet. Durch die Implementierung beider Layer ist eine erhöhte Komplexität und damit ein größeres Potential für die Sammlung von Erfahrung mit den Big Data Science Techniken gegeben.

## Skizzierung der gewählten Architektur
Der folgenden Abbildung 1 ist die zugrundeliegende Architektur der Big Data Science Plattform zu entnehmen. Die Pfeile in der Abbildung zeigen vom Aufrufer zum Empfänger. Der Load Balancer empfängt Web-Anfragen und leitet sie an die Web Server weiter. Die Web Server können je nach Anfrage auf den Cache oder auf die Datenbank zugreifen. Bei der Anfrage /webrequests, werden die Daten aus der Datenbank gelesen und nicht im Cache gespeichert. Alle anderen Anfragen versuchen zunächst die Daten aus dem Cache zu laden und wenn diese dort nicht vorhanden sind, greifen sie auf die Datenbank zu, speichern die Daten in den Cache und geben sie anschließend zurück. Die URLs der Anfragen werden mithilfe von Kafka in ein Topic geschrieben. Die Verarbeitung der Daten erfolgt mithilfe von Spark Structured Streaming. Hierbei werden die Anfragen nach der URL gruppiert und in die Datenbank web_requests gespeichert.

Im Batch Layer erfolgt zunächst die Speicherung der CSV-Dateien im Data Lake und anschließend deren Verarbeitung mithilfe von Spark. Dafür wird die vorliegenden CSV-Dateien (aktuellen Spotify-Datensätze) zusammengeführt und anschließend in der Datenbank spotify_cases gespeichert.

Der Speed Layer bearbeitet nicht nur die Daten die vom Kafka System geliefert werden, sondern simuliert durch das Generieren von Daten die Anzeige von neuen und aktuellen Spotify-Datensätze. Dies wird durch einen TCP Server realisiert, der in kurzen Zeitabständen neue Daten generiert und an die Spark Streaming Komponente sendet. Dabei wird ein Künstler und die Anzahl der Streams (Klickzahlen in einem beliebigen Lied) zufällig gewählt und verarbeitet. Abschließend erfolgt die Speicherung der Daten in der Datenbank live_spotify.

TODO AF: Abbildung der Architektur
