# Spotify-Auswertung-Big-Data-Plattform

Big-Data-Anwendung zur Auswertung und Analyse der Spotify-Datensätze.

## Beschreibung des Projekts

# Einleitung:

In der Vorlesung “Data Science & Big Data” besteht die Prüfungsleistung aus zwei verschiedenen Laborberichten. Das Ziel der Gruppenaufgabe im Laborbericht 1 ist es, eine Applikation für einen Anwendungsfall zu entwickeln. Diese soll, die in der Vorlesung kennen gelernte Ziel-Architektur, realisieren.

Zu Beginn des Projekts wurde das Projektteam definiert und sich auf eine Projektdokumentation geeinigt. Als Versionsverwaltung des Software-Entwicklungsprojekts wurde sich auf GitHub festgelegt. Das tracken der Aufgaben innerhalb des Projekts erfolgte in der README-Datei des Repositorys. Die gruppeninterne Kommunikation erfolgt in einer WhatsApp-Gruppe.

# Identifikation des Use Cases

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
Die zugrundeliegende Aufgabenstellung und die Rahmenbedingungen sind dem verlinkten PDF Dokument zu entnehmen.

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
$ cd source
$ bash start.sh
$ cd ..
```

### Start Web Application-Cluster

1. Selektieren des Web Applikation Directorys

```
$ cd source/app
```

2. Minikube ingress Add-on freischalten

```
$ minikube addons enable ingress
```

3. Setzen des Docker Build Kontextes auf Minikube

```
$ eval $(minikube docker-env)
```

4. Bauen des Applikationsimages aus dem Dockerfile `source/app/app-web/Dockerfile`

```
$ cd web
$ docker build -t my-super-web-app .
$ cd ..
```

5. Bauen des Databaseimages aus dem Dockerfile `source/app/database/Dockerfile`

```
$ cd db
$ docker build -t my-super-mysql-database .
$ cd ..
```

6. Ausführen der YAML-Dateien mit Bauanleitung der Infrastruktur

```
$ kubectl apply -f mysql.yml
$ kubectl apply -f service.yml
$ kubectl apply -f memcached.yml
$ kubectl apply -f deployment.yml
```

Alternativ können die einzelnen Schritte über die Ausführung eines Skripts umgesetzt werden:

```
$ cd source/app
$ bash startWeb.sh
```

### Start Big Data-Cluster

#### Start Kafka

Der Start von Kafka erfolgt anhand eines bereitgestellten Skripts:

```
$ cd source/data/kafka
$ bash startKafka.sh
```

#### Start Hadoop

1. Selektieren des HDFS-Directorys

```
$ cd source/hdfs_data_lake
```

2. Helm Repository 'stable' hinzufügen und HDFS-Cluster starten

```
$ helm repo add stable https://kubernetes-charts.storage.googleapis.com/
$ helm install --namespace=default --set hdfs.dataNode.replicas=3 --set yarn.nodeManager.replicas=3 --set hdfs.webhdfs.enabled=true my-hadoop-cluster stable/hadoop
```

Die "Replicas" werden im Rahmen dieser prototypischen Anwendung jeweils auf drei gesetzt. Im Praxisfall würde die Anzahl dieser Nodes je nach Bedarf nach oben oder unten skaliert werden.

Für Demo-Zwecke wurde hier im Nachgang ein künstlicher Timer von 2 Minuten eingebaut, um bei der Erst-Erstellung der Docker-Container genügend Vorlaufzeit zur Verfügung zu stellen. Je nach lokaler Umgebung, kann dieser Schritt längere Zeit beanspruchen.

3. Helm repository 'pfisterer-knox' hinzufügen

```
$ helm repo add pfisterer-knox https://pfisterer.github.io/apache-knox-helm/
$ helm install \
        --set "knox.hadoop.nameNodeUrl=hdfs://my-hadoop-cluster-hadoop-hdfs-nn:9000/"  \
        --set "knox.hadoop.resourceManagerUrl=http://my-hadoop-cluster-hadoop-yarn-rm:8088/ws" \
        --set "knox.hadoop.webHdfsUrl=http://my-hadoop-cluster-hadoop-hdfs-nn:50070/webhdfs/" \
        --set "knox.hadoop.hdfsUIUrl=http://my-hadoop-cluster-hadoop-hdfs-nn:50070" \
        --set "knox.hadoop.yarnUIUrl=http://my-hadoop-cluster-hadoop-yarn-ui:8088" \
        --set "knox.servicetype=LoadBalancer" \
        knox pfisterer-knox/apache-knox-helm

```

4. 'input' Ordner erstellen und Daten initial laden

```
$ kubectl exec -ti my-hadoop-cluster-hadoop-yarn-rm-0 -- bash -c "hdfs dfs -mkdir -p input && hdfs dfs -chmod -R 777 input | hdfs dfs -put - input/spotifydata"
$ kubectl exec -ti my-hadoop-cluster-hadoop-yarn-rm-0 -- bash -c "hdfs dfs -ls input"
```

Alternativ können die vorangegangen Setup-Schritte über folgende Kommandozeilenbefehle zusammengefasst werden:

```
$ cd source/hdfs_data_lake
$ bash startHDFS.sh
```

#### Start Spark and Submit Instructions

Spark lässt sich mit folgendem Befehl ausführen:

```
$ cd source/data
$ bash startSpark.sh
```

Das Skript kümmert sich um die Ausführung der folgenden Arbeitsschritte:

- Anlegen von entsprechenden Berechtigungen in Kubernetes
- Transfer der Daten und Skripte in das HDFS-Cluster
- Durchführung des Spark-Submits für das Batch-Processing zur Verarbeitung der Daten aus dem HDFS-Cluster und die Ablage in die MySQL Datenbank
- Starten der Streaming Prozesse im Hintergrund

Beide Streaming Prozesse können auch über den folgenden Befehl gestartet werden:

```
$ bash startStreaming.sh
```

Mit dem folgendem Befehl wird das Stream-Processing in Spark aktiviert:

```
$ bash submitStreaming.sh
```

Mit dem folgenden Befehl wird das Stream-Processing aus Kafka aktiviert:

```
$ bash submitKafka.sh
```

### Upload der Daten

Die unter `/collection` befindlichen Daten können über die folgenden Kommandozeilenbefehle in das HDFS-Cluster geladen werden:

```
$ cd source/data
$ bash uploadData.sh
```

### Aktualisierung der Daten

Der folgende Aufruf, aktualisiert die Datenanalyseskripte und transferiert sie an das HDFS-Cluster:

```
$ cd source/data
$ bash updateScript.sh
```

### Submit der Skripte

Der folgende Aufruf submitted alle Skripte an Spark:

```
$ cd source/data
$ bash submit.sh
$ bash submitStreaming.sh
$ bash submitKafka.sh
```

## Herunterfahren der Cluster

Die Cluster können entweder einzeln oder vollständig heruntergefahren werden. Die folgende Ausführung beschreibt, wie das vollständige herunterfahren der Cluster, über ein Skript, erfolgen kann:

```
$ cd source
$ bash delete.sh
$ cd ..
```

Im Folgenden wird beschrieben, wie die einzelnen Cluster einzelnen herunterzufahren sind:

1. Web-Cluster

```
$ cd source/app
$ bash deleteWeb.sh
$ cd ../..
```

2. Hadoop-Cluster

```
$ cd source/hdfs_data_lake
$ bash deleteHDFS.sh
$ cd ../..
```

3. Kafka-Cluster

```
$ cd source/data/kafka
$ bash deleteKafka.sh
$ cd ../../..
```

4. Spark

```
$ cd source/data
$ bash deleteAllSparkpods.sh
$ cd ../../..
```

## Dokumentation des Source-Code

Im folgenden soll die Ordnerstruktur der Anwendung erklärt werden:

- `doc:` gesamte Dokumentation inklusive Aufgabenstellung
- `collection:` enthält unsere Datensätze (in .csv Format)
- `source:` Quellcode für das Aufsetzen des Clusters und die Website
  - `app:` Beinhaltet alle Dateien, die die Web-Applikation und deren Umgebung aufbauen
    - `database:` Scripts für den Insert in die Datenbank
    - `app-web:` Enthät Javascript Datei der Web-Applikation und Dockerfile, das diese Initiiert
  - `data:` Alle Dateien, die zur Installation nätig sind
    - `kafka:` Kafka-Cluster
    - `streaming:` Streaming
    - `batch:` Beinhaltet Skript für Datenbank-Insert
  - `hdfs_data_lake:` Ansammlung der ganzen Datensätze

## Ziel-Architektur

Im Rahmen der Vorlesung wurden zwei fundamentale Architekturmodelle zur möglichen Modellierung einer Big Data Science Plattform vertieft. Eine solche Architektur wird benötigt, um die Anforderungen an die Anwendung optimal lösen zu können. Zunächst werden die zwei Architekturen miteinander verglichen und anschließend eine Auswahl vorgenommen.

## Kappa-Architektur vs. Lambda-Architektur

### Lambda Architektur

Die Lambda Architektur wurde 2011 von Nathan Marz vorgestellt. Die Besonderheit der Architektur liegt in der Aufteilung zwischen einem Batch und Speed Layer begründet. Im Batch Layer werden die eingehenden Rohdaten gespeichert und verarbeitet. Die Daten werden zunächst nicht prozessiert, sondern erst nach bestimmten Zeitabständen. Dabei können die Zeitfenster von einigen Stunden bis hin zu Wochen variieren. Die Prozessierung im Batch Layer wird auf allen bis dahin gesammelten Daten durchgeführt und kann daher einige Zeit in Anspruch nehmen. Das Ergebnis wird anschließend im Serving-Layer gespeichert. Um neu eintreffende Daten nicht erst im nächsten Batch Prozess abzuarbeiten, erfolgt die Verarbeitung dieser Daten im Speed Layer. Dieser prozessiert die Daten in Echtzeit und stellt eine Ergänzung der Batch-Ansicht dar. Zur Beschleunigung des Vorgangs wird oftmals auf die komplexeren und aufwändigeren Regeln zur Vorverarbeitung der Daten verzichtet. Das Ergebnis des Speed Layers wird ebenfalls im Serving-Layer gespeichert.

### Kappa-Architektur

Die Kappa Architektur wurde 2014 von Jay Kreps vorgestellt und stellt eine Vereinfachung der Lambda-Architektur dar. Die Vereinfachung wird erreicht, indem der Batch Layer entfernt und alle Daten von dem Stream-Processing-Layer prozessiert werden. Die Speicherung des Ergebnisses erfolgt ebenfalls im Serving-Layer. Die Prozessierung von neuen Daten erfolgt durch den Start eines neuen Stream-Prozessing Prozesses. Sobald das neue Ergebnis vorliegt, wird der alte Stream-Processing Job gestoppt und die Ergebnisse werden gelöscht.

Vergleich der Architekturen
Beide Architekturen eignen sich nach wie vor zur Modellierung einer Big Data Science Plattform. Obwohl die Kappa-Architektur neuer ist und eine Vereinfachung darstellt, gibt es weiterhin Anwendungsfälle für die Lambda-Architektur. Eine Besonderheit der Kappa-Architektur ist, dass sich die Anwendungsfälle immer als ein Streamingproblem beschreiben lassen müssen.

Die im CSV-Format vorliegenden Spotify-Datensätze sollen allerdings nur täglich verarbeitet und aktualisiert werden. Aufgrund dessen, dass die Kappa-Architektur sich als Streamingproblem beschreiben lassen muss, wurde die Lambda-Architektur gewählt. Dadurch können Daten aus der CSV-Datei direkt vom Batch Layer bearbeitet und gleichzeitig eine Live-Analyse zu neuen Fällen, mithilfe des Speed Layers, durchgeführt werden.

Ein weiterer Punkt der für die Lambda Architektur spricht, liegt im Aufbau der Architektur begründet. Während die Kappa-Architektur lediglich aus dem Speed Layer besteht, werden bei der Lambda-Architektur der Batch und Speed Layer verwendet. Durch die Implementierung beider Layer ist eine erhöhte Komplexität und damit ein größeres Potential für die Sammlung von Erfahrung mit den Big Data Science Techniken gegeben.

## Skizzierung der gewählten Architektur

Der folgenden Abbildung 1 ist die zugrundeliegende Architektur der Big Data Science Plattform zu entnehmen. Die Pfeile in der Abbildung zeigen vom Aufrufer zum Empfänger. Der Load Balancer empfängt Web-Anfragen und leitet sie an die Web Server weiter. Die Web Server können je nach Anfrage auf den Cache oder auf die Datenbank zugreifen. Bei der Anfrage /webrequests, werden die Daten aus der Datenbank gelesen und nicht im Cache gespeichert. Alle anderen Anfragen versuchen zunächst die Daten aus dem Cache zu laden und wenn diese dort nicht vorhanden sind, greifen sie auf die Datenbank zu, speichern die Daten in den Cache und geben sie anschließend zurück. Die URLs der Anfragen werden mithilfe von Kafka in ein Topic geschrieben. Die Verarbeitung der Daten erfolgt mithilfe von Spark Structured Streaming. Hierbei werden die Anfragen nach der URL gruppiert und in die Datenbank web_requests gespeichert.

Im Batch Layer erfolgt zunächst die Speicherung der CSV-Dateien im Data Lake und anschließend deren Verarbeitung mithilfe von Spark. Dafür wird die vorliegenden CSV-Dateien (aktuellen Spotify-Datensätze) zusammengeführt und anschließend in der Datenbank spotify_cases gespeichert.

Der Speed Layer bearbeitet nicht nur die Daten die vom Kafka System geliefert werden, sondern simuliert durch das Generieren von Daten die Anzeige von neuen und aktuellen Spotify-Datensätze. Dies wird durch einen TCP Server realisiert, der in kurzen Zeitabständen neue Daten generiert und an die Spark Streaming Komponente sendet. Dabei wird ein Künstler und die Anzahl der Streams (Klickzahlen in einem beliebigen Lied) zufällig gewählt und verarbeitet. Abschließend erfolgt die Speicherung der Daten in der Datenbank live_spotify.

TODO AF: Abbildung der Architektur
