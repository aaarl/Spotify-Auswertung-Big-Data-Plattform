# Spotify-Auswertung-Big-Data-Plattform

Big-Data-Anwendung zur Auswertung und Analyse der Spotify-Datensätze.

# Einleitung:

In der Vorlesung “Data Science & Big Data” besteht die Prüfungsleistung aus zwei verschiedenen Laborberichten.
Das Ziel der Gruppenaufgabe im Laborbericht 1 ist es, eine Applikation für einen Anwendungsfall zu entwickeln. Diese soll, die in der Vorlesung kennengelernte Ziel-Architektur, realisieren.
Zu Beginn des Projekts wurde das Projektteam definiert und sich auf eine Projektdokumentation geeinigt.
Als Versionsverwaltung des Software-Entwicklungsprojekts wurde GitHub ausgewählt. Das Tracken der Aufgaben innerhalb des Projekts erfolgte in der README-Datei des Repositorys.
Die gruppeninterne Kommunikation erfolgt in einer WhatsApp-Gruppe.

Das Repository ist öffentlich und kann unter folgendem Link aufgerufen werden:
https://github.com/aaarl/Spotify-Auswertung-Big-Data-Plattform

Links sind in Youtube, da in Github keine Datensätze > 100Mb zulässig sind.
Screencast_001: https://www.youtube.com/watch?v=16CqER2p7Lo

Enthält den gesamten Ablauf (Minikube starten, Start Web App Cluster, Start Kafka, Start Hadoop, Start Spark - Anzeige der entsprechenden Hadoop-Cluster und erfolgreiches Aufsetzen des Setups)
Screencast_002: https://www.youtube.com/watch?v=4Zse5u0wUug

Problematik Upload von Dateien in HDFS (obwohl HDFS erfolgreich konfiguriert und ansprechbar über Web-UI)
Screencast_003: https://www.youtube.com/watch?v=5oyLurJH1rc

Kommunikation HDFS über Web-UI, Aufrufe mit HTTP Request Maker, Anzeige der entsprechenden Logs für Hadoop, Anzeige der Datanode Information und des Datanode Usage Histogramms, Veranschaulichung der darin enthaltenen Informationen (Volume Information und Block Pools)

# Erarbeitung des Use Cases

In einem, per Videoschalte durchgeführten Workshop, wurde der Anwendungsfall für die Big Data Applikation erarbeitet. Als erstes wurden in einem Brainstorming fünf verschiedene Use Cases genannt. Diese wurden anschließend von den Projektmitgliedern ausformuliert.

| Nummer | Thema                                                                  |
| :----: | :--------------------------------------------------------------------- |
|   1    | Spotify Dashboard - Ausgabe von Hitlisten                              |
|   2    | US-Wahl: Abstimmungsergebnisse in einzelnen Regionen darstellen        |
|   3    | Corona: Infektionszahlen in verschiedenen Landkreisen                  |
|   4    | Afrikanische Schweinepest: Wildschweinabschüsse mit positiver Inzidenz |
|   5    | Weltweit häufigste Krankheiten in einer Liste darstellen               |

Nach einer sorgfältigen Erwägung des Fürs und Widers der jeweiligen Use Cases, wurde sich auf die Anwendung “Spotify Dashboard - Ausgabe von Hitlisten” festgelegt. Als vorteilhaft für diese Anwendung zeigten sich eine bereits große Menge an verfügbaren Daten, ein klares Zielbild der Applikation, sowie eine positive Assoziation mit dem Thema Musik.

# Konzept

Aufgabenstellung
Die zugrundeliegende Aufgabenstellung und die Rahmenbedingungen sind dem verlinkten PDF Dokument zu entnehmen:
https://github.com/aaarl/Spotify-Auswertung-Big-Data-Plattform/blob/main/documentation/Aufgabenstellung_BigData_Vorlesung_Okt_2020.pdf

## Technische Voraussetzungen

Für das Aufsetzen der Big Data Science Plattform wird eine laufende Kubernetes Umgebung vorausgesetzt. In den folgenden Beispielen wird eine laufende Minikube Umgebung angenommen. Im nachfolgenden Kommandozeilenausschnitt ist die Anleitung zum Start von Minikube dargestellt:

```
$ minikube start
$ # or under Windows still give the appropriate parameters so that the minicube contains sufficient resources:
$ minikube start --cpus 6 --memory 6614
```

## Ausführung

Alle CMD-Reihen der folgenden Unterkapitel starten jeweils am Kapitelanfang im Home Directory des Git Repositorys.

Eine Anleitung zu einem schrittweisen Aufsetzen des Clusters, der Web Application und Big Data, ist in den folgenden Unterkapiteln erläutert. Alternativ kann die Big Data Science Plattform, unter Berücksichtigung der Voraussetzungen, anhand folgender Anleitung vollständig automatisiert aufgebaut werden:

```
$ bash start.sh
```

Um die unten genannten automatisierten Skripte nutzen zu können, muss der korrekte Pfad gewährleistet werden (über `cd {path}`)

## Start Web Application-Cluster

```
# Selektieren des Web Applikation Directorys
$ cd source/app

# Minikube ingress Add-on freischalten
$ minikube addons enable ingress

# Setzen des Docker Build Kontextes auf Minikube
$ eval $(minikube docker-env)

# Bauen des Applikationsimages aus dem Dockerfile `source/app/app-web/Dockerfile`
$ docker build -t my-super-web-app .

# Bauen des Databaseimages aus dem Dockerfile `source/app/database/Dockerfile`
$ docker build -t my-super-mysql-database .

# Ausführen der YAML-Dateien mit Bauanleitung der Infrastruktur
$ kubectl apply -f mysql.yml
$ kubectl apply -f service.yml
$ kubectl apply -f memcached.yml
$ kubectl apply -f deployment.yml
```

Alternativ können die einzelnen Schritte über die Ausführung des Skriptes `startWeb.sh` umgesetzt werden:

```
$ bash startWeb.sh
```

## Start Big Data-Cluster

### Start Kafka

Der Start von Kafka erfolgt anhand eines bereitgestellten Skripts:

```
$ bash startKafka.sh
```

### Start Hadoop

```
# Selektieren des HDFS-Directorys
$ cd source/hdfs_data_lake

# Helm Repository 'stable' hinzufügen und HDFS-Cluster starten
$ helm repo add stable https://charts.helm.sh/stable --force-update
$ helm install --namespace=default --set hdfs.webhdfs.enabled=true my-hadoop-cluster stable/hadoop
```

Die `replicas` dieser Nodes können je nach Bedarf nach oben oder unten skaliert werden.

Um bei der Erst-Erstellung der Docker-Container genügend Vorlaufzeit zur Verfügung zu stellen wurde ein `sleep` eingebaut. Je nach lokaler Umgebung, kann dieser Schritt längere Zeit beanspruchen. Alternativ können hier auf die beiden Skripte `startHDFS_1.sh` und `startHDFS_2.sh` genutzt werden. Diese sind nur von `startHDFS.sh` getrennt um die einzelnen Durchlaufschnitte besser nachvollziehen zu können. Hier wird eine Schleife erzeugt, die Logs ausgibt bis die Umgebung eingerichtet wurde.

```
# Helm repository 'pfisterer-knox' hinzufügen
$ helm repo add pfisterer-knox https://pfisterer.github.io/apache-knox-helm/
$ helm install \
 --set "knox.hadoop.nameNodeUrl=hdfs://my-hadoop-cluster-hadoop-hdfs-nn:9000/" \
 --set "knox.hadoop.resourceManagerUrl=http://my-hadoop-cluster-hadoop-yarn-rm:8088/ws" \
 --set "knox.hadoop.webHdfsUrl=http://my-hadoop-cluster-hadoop-hdfs-nn:50070/webhdfs/" \
 --set "knox.hadoop.hdfsUIUrl=http://my-hadoop-cluster-hadoop-hdfs-nn:50070" \
 --set "knox.hadoop.yarnUIUrl=http://my-hadoop-cluster-hadoop-yarn-ui:8088" \
 --set "knox.servicetype=LoadBalancer" \
 knox pfisterer-knox/apache-knox-helm

# 'input' Ordner erstellen und Daten initial laden
$ kubectl exec -ti my-hadoop-cluster-hadoop-yarn-rm-0 -- bash -c "hdfs dfs -mkdir -p input && hdfs dfs -chmod -R 777 input | hdfs dfs -put - input/spotifydata"
$ kubectl exec -ti my-hadoop-cluster-hadoop-yarn-rm-0 -- bash -c "hdfs dfs -ls input"
```

Alternativ können die vorangegangen Setup-Schritte über folgende Kommandozeilenbefehle zusammengefasst werden:

```
$ bash startHDFS.sh
```

### Start Spark and Submit Instructions

Spark lässt sich mit folgendem Befehl ausführen:

```
$ bash startSpark.sh
```

Das Skript kümmert sich um die Ausführung der folgenden Arbeitsschritte:

1. Anlegen von entsprechenden Berechtigungen in Kubernetes
2. Transfer der Daten und Skripte in das HDFS-Cluster
3. Durchführung des Spark-Submits für das Batch-Processing zur Verarbeitung der Daten aus dem HDFS-Cluster und die Ablage in die MySQL Datenbank
4. Starten der Streaming Prozesse im Hintergrund

```
# Beide Streaming Prozesse können auch über den folgenden Befehl gestartet werden:
$ bash startStreaming.sh

# Mit dem folgendem Befehl wird das Stream-Processing in Spark aktiviert:
$ bash submitStreaming.sh

# Mit dem folgenden Befehl wird das Stream-Processing aus Kafka aktiviert:
$ bash submitKafka.sh
```

## Upload der Daten

Die unter `/collection` befindlichen Daten können über die folgenden Kommandozeilenbefehle in das HDFS-Cluster geladen werden:

```
$ bash uploadData.sh
```

### Aktualisierung der Daten (falls notwendig)

Der folgende Aufruf, aktualisiert die Datenanalyseskripte und transferiert sie an das HDFS-Cluster:

```
$ bash updateScript.sh
```

### Submit der Skripte

Der folgende Aufruf submitted alle Skripte an Spark:

```
$ cd source/data
$ bash submitData.sh
$ bash submitStreaming.sh
$ bash submitKafka.sh
```

## Herunterfahren der Cluster

Die Cluster können entweder einzeln oder vollständig heruntergefahren werden. Die folgende Ausführung beschreibt, wie das vollständige herunterfahren der Cluster, über ein Skript, erfolgen kann:

```
$ bash delete.sh
```

Im Folgenden wird beschrieben, wie die einzelnen Cluster einzelnen herunterzufahren sind (entsprechende Pfadvergabe ist hier zu beachten):

```
# Web-Cluster
$ bash deleteWeb.sh

# Hadoop-Cluster
$ bash deleteHDFS.sh

# Kafka-Cluster
$ bash deleteKafka.sh

# Spark
$ bash deleteAllSparkpods.sh
```

# Architektur

## Ziel-Architektur

Im Rahmen der Vorlesung wurden zwei fundamentale Architekturmodelle zur möglichen Modellierung einer Big Data Science Plattform vertieft. Eine solche Architektur wird benötigt, um die Anforderungen an die Anwendung optimal lösen zu können. Zunächst werden die zwei Architekturen miteinander verglichen und anschließend eine Auswahl vorgenommen.

### Lambda Architektur

Eine Lambda-Architektur beschreibt einen Systemaufbau aus drei Bereichen, den sogenannten Layern, bestehend aus Batch Layer, Speed Layer und Serving Layer.
Die Architektur wurde von Nathan Marz entwickelt und gehört in den Bereich der sogenannten Big Data Technologien.
Eine Lambda-Architektur verwendet unterschiedliche Technologien zur Verarbeitung der riesigen Datenmengen. In den einzelnen Layern kommen spezialisierte Systeme, wie zum Besipiel Apache Hadoop, zum Einsatz, die für die jeweilige Aufgabe optimiert werden.
Mit der Lambda-Architektur lassen sich riesige Datenmengen in relativ kurzer Zeit speichern und verarbeiten. Das Verarbeitungsprinzip leitet sich aus der funktionalen Programmierung ab, in der Daten nie verändert, sondern lediglich Kopien erzeugt und gespeichert werden.

Die Besonderheit der Architektur liegt in der Aufteilung zwischen einem Batch und Speed Layer begründet. Im Batch Layer werden die eingehenden Rohdaten gespeichert und verarbeitet. Die Daten werden zunächst nicht prozessiert, sondern erst nach bestimmten Zeitabständen. Dabei können die Zeitfenster von einigen Stunden bis hin zu Wochen variieren. Die Prozessierung im Batch Layer wird auf allen bis dahin gesammelten Daten durchgeführt und kann daher einige Zeit in Anspruch nehmen. Das Ergebnis wird anschließend im Serving-Layer gespeichert. Um neu eintreffende Daten nicht erst im nächsten Batch Prozess abzuarbeiten, erfolgt die Verarbeitung dieser Daten im Speed Layer. Dieser prozessiert die Daten in Echtzeit und stellt eine Ergänzung der Batch-Ansicht dar. Zur Beschleunigung des Vorgangs wird oftmals auf die komplexeren und aufwändigeren Regeln zur Vorverarbeitung der Daten verzichtet. Das Ergebnis des Speed Layers wird ebenfalls im Serving-Layer gespeichert.

_Quelle: https://www.datenbanken-verstehen.de/lexikon/lambda-architektur/_

Im folgenden wird die Lamda-Architektur aus der Vorlesung auf unser Projekt übertragen und dargestellt:

![Lambda-Architektur unseres Projekts](https://github.com/aaarl/Spotify-Auswertung-Big-Data-Plattform/blob/main/documentation/Lambda-Architektur.PNG)

## Ausgewählte Architektur

![Lambda-Architektur unseres Projekts](https://github.com/aaarl/Spotify-Auswertung-Big-Data-Plattform/blob/main/documentation/Lambda-Architektur.PNG)

Die obige Abbildung beschreibt die gesamte Big-Data Architektur mit den dazugehörigen Partitionen wie der Proprietary Application (Web Application), der Lambda-Architektur welche in Abschnitt 4.2 näher beschrieben wurde, dem Data-Lake zur Batch-Layer und Spark für die Speed-Layer (Berechnung der neuesten Daten/ Echtzeit-Ansicht).
Die Pfeile in der Abbildung zeigen vom Aufrufer zum Empfänger. Der Load Balancer empfängt Web-Anfragen und leitet diese an die Web-Server weiter.
Die Web Server können je nach Anfrage auf den Cache oder auf die Datenbank zugreifen. Bei der Anfrage (Web-Requests) sollen die Daten aus der Datenbank gelesen und nicht im Cache gespeichert werden.
Alle anderen Anfragen versuchen zunächst die Daten aus dem Cache zu laden und wenn diese dort nicht vorhanden sind, greifen sie auf die Datenbank zu, speichern die Daten in den Cache und geben sie anschließend zurück.
Die URLs der Anfragen werden mithilfe von Kafka in ein Topic geschrieben. Die Verarbeitung der Daten erfolgt mithilfe von Spark Structured Streaming.
Hierbei werden die Anfragen nach der URL gruppiert und in die Datenbank gespeichert. Im Batch-Layer erfolgt zunächst die Speicherung der CSV-Dateien im Data Lake und anschließend deren Verarbeitung mithilfe von Spark (dabei wird die erstellte CSV-Datei zusammengeführt und anschließend in der Datenbank gespeichert).
Der Speed-Layer bearbeitet nicht nur die Daten die von dem Kafka-System geliefert werden, sondern simuliert durch das Generieren von Daten die Anzeige von neuen und aktuellen Spotify-Datensätze.
Dies wird durch einen TCP Server realisiert und an die Spark Streaming Komponente sendet. Dabei werden die Künstler und die Anzahl der Streams (Klickzahl des entsprechenden artist über timesListened ) zufällig gewählt und verarbeitet. Abschließend erfolgt die Speicherung der Daten in der Datenbank.

## Dokumentation

Im Folgenden soll die Ordnerstruktur der Anwendung erklärt werden, aus der die Struktur
des Quellcodes hervorgeht:

- **documentation**: gesamte Dokumentation inklusive Aufgabenstellung
- **collection**: enthält unsere Datensätze (in .csv Format)
- **source**: Quellcode für das Aufsetzen des Clusters und die Website
- **application**: Beinhaltet alle Dateien, die die Web-Applikation und deren Umgebung aufbauen
- **database**: Scripts für den Insert in die Datenbank
- **web-application**: Enthält Javascript Datei der Web-Applikation und Dockerfile, welches diese initiiert
- **data**: Alle Dateien, die zur Installation nötig sind
- **kafka**: Kafka-Cluster
- **streaming**: Streaming
- **batch**: Beinhaltet Skript für Datenbank-Insert
- **hadoop**: Ansammlung der ganzen Datensätze

# Technische Hindernisse

## Windows 10 Home/ Hyper-V

Nach Ausführung des Bash-Skriptes `startWeb.sh` erhält der Nutzer folgende Warnung beim Ausführen des Befehls `minikube addons enable ingress`:

`Exiting due to MK_USAGE: Due to networking limitations of driver docker on windows, ingress addon is not supported. Alternatively to use this addon you can use a vm-based driver: 'minikube start --vm=true'`

Daraus resultiert, dass es dem Nutzer nicht möglich ist, Addons für das Minikube zu aktivieren oder freizuschalten.
Somit ist eine weitere Voraussetzung eine lauffähige Windows 10 Pro-Version zu besitzen, da nur hier die Freischaltung von Hyper-V möglich ist.
Docker Desktop auf Windows 10 unterstützt zwei Backends: HyperV und WSL2. WSL2 verwendet ebenfalls Hyper-V. Daher ist es nicht möglich Docker Desktop ohne aktiviertes Hyper-V zu starten bzw. zu verwenden.
Um Windows-Container (ohne Hyper-V) auszuführen, muss ein laufender Docker-Engine-Daemon installiert werden, welcher auf die benannten Pipes hört.
Dieser Daemon kann native Windows-Container über eine Prozessisolierung ausführen.
Nach Umstieg auf eine Windows 10 Pro-Version konnte das obige Problem behoben werden.
Anschließend schien es, dass Minikube nicht als VM läuft, dieses aber den Docker-Treiber verwendet.
Der Docker-Treiber benötigt eine höhere Kapazität der Speicherressourcen und somit wurde auch die Leistung der `--memory` für die nächsten Tests auf `--memory = 6114` gesetzt.
Um die Lauffähigkeit garantieren zu können, wurden hier auch weitere Parameter wie bspw. `--vm = true` und `--driver = hyperkit` ergänzt. Nach Auftreten der unten geschilderten Probleme (6.2 bis 6.5) schien es, dass die Windows-Umgebung gänzlich ungeeignet für den geschilderten Use-Case ist.
Daher wurde die strategische Entscheidung getroffen die weitere Implementierung und Ausführung auf einer virtuellen Maschine (Linux Ubuntu auszuführen).

## Lauffähigkeit der einzelnen Systeme

Bereits während der Ausführung der einzelnen Bash-Skripte erscheinen sporadische
Fehlermeldungen oder Warnungen (unter Linux Ubuntu kaum, jedoch vermehrt unter dem
Windows-Betriebssystem) wie:

- `Error: failed to download "strimzi/strimzi-kafka-operator" (hint: running `helm repo
  update` may help)`
- `“stable" has been added to your repositories` `WARNING: This chart is deprecated`
- `Warning: networking.k8s.io/v1beta1 Ingress is deprecated in v1.19+, unavailable in v1.22+ 12`
- (ohne Hyper-V auf Windows): `CrashLoopBackOff im “mysql-deployment-7549d55948-vgl87”-Pod`

## Hochladen der Daten ins HDFS

Wie aus dem Screencast zu entnehmen ist, sind alle Hadoop-Cluster und Pods lauffähig und besitzen eine konstante Lauffähigkeit ohne abzustürzen.
Jedoch ist es nicht möglich, Daten in das Cluster hochzuladen. Eine Statusabfrage über Web-Api, Terminal oder pyweb ist möglich und wird während des Betriebs gewährleistet.
Beim Test manuell eine Datei in das HDFS hochzuladen erscheint folgende Fehlermeldung:

`Couldn’t find datanode to write file. Method Not Allowed.`

Auch in der Datanode-Übersicht (Web-UI) wird die Nutzung mit entsprechendem Histogramm dargestellt.
Auch eine HTTP-Adresse wird angezeigt (Screencast_003 in Minute 3:15) und sämtliche Aufrufe über einen HTTP-Request-Marker können ausgeführt werden.
Auch der Status (Screencast_003 in Minute 5:17)

## Cluster (Status: Running)

Nach erfolgreichen Aufsetzen der Cluster ist es dennoch nicht möglich gewesen, einen URL-Aufruf unter der Hadoop-IP durchzuführen.

![Lambda-Architektur unseres Projekts](https://github.com/aaarl/Spotify-Auswertung-Big-Data-Plattform/blob/main/documentation/Hadoop-Cluster.PNG)

Wie aus der Abbildung zu entnehmen ist, sind alle Hadoop-Cluster, Kubernetes-Pods und das gesamte Deployment valid und erreichbar.
In Screencast_002 ist zu sehen, wie der Aufruf einzelner Hadoop-Cluster via VS-Code-Terminal versucht wird.
Aus den Directory-Logs über die Web-UI (Aufruf Hadoop-Cluster) ist ersichtlich, warum eine Verbindung bzw. das Hochladen von Dateien nicht gewährleistet werden kann.
In der Hadoop-Web-UI werden die Nodes der einzelnen Cluster und die Heartbeats angezeigt.

![Lambda-Architektur unseres Projekts](https://github.com/aaarl/Spotify-Auswertung-Big-Data-Plattform/blob/main/documentation/Hadoop-WebUI.PNG)

## Apache Knox

Das Hauptproblem scheint an Apache Knox zu sein. Apache Knox ist ein Application Gateway für die Interaktion mit den REST-APIs und UIs von Apache-Hadoop-Implementierungen.
Dieses Diagramm ist in erster Linie für den Zugriff auf HDFS von außerhalb eines Kubernetes-Clusters über einfache REST-APIs angedacht.
In dem Spotify-Use-Case scheint Apache Knox sich auch auf das HDFS zu verbinden, jedoch ist es nicht möglich (Problem 6.3) Dateien hochzuladen.
Die Annahme ist, dass Apache und Knox nicht kompatibel sind. Anhand einer nicht ersichtlichen Meldung während des Programm-Durchlaufs ist aufgefallen,
dass ein verwendetes Repository (aus dem Skript) nicht mehr supportet wird. Es handelt sich um das Repository helm/charts (Link: https://github.com/helm/charts ).
Ab dem 13. November wurde der Support vollständig eingestellt. Zu diesem Zeitpunkt werden die Stable- und Incubator-Chart-Repos als veraltet markiert.
Daher wurden zu dem Zeitpunkt diese Diagramm-Repos vermutlich gelöscht und sind nicht mehr verfügbar. Dieses Git-Repository wird als Archiv beibehalten.
Da sonstige Probleme oder Bugs nicht mehr behoben werden, kann dies zu den oben genannten Probleme führen.
Aus dem Vorlesungsmaterial wird eine Alternativlösung nicht ersichtlich.
Möglich wäre es, ein anderes `helm-chart zu verwendet`, jedoch muss dieses daraufhin mit dem Apache Knox (Link: https://github.com/pfisterer/apache-knox-helm ) kompatibel sein.
