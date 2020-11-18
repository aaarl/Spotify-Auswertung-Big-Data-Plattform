#!/bin/bash

# ------------------Kafka---------------------

cd data/kafka/
echo "Start Kafka"
bash startKafka.sh
cd ../..

# ----------------Web----------------------

# Selektieren des Working Directories für die web app
cd app

# Starten des Web Clusters
echo "Start Web Cluster"
bash startWeb.sh

# Auf home dir wechseln
cd ..


# ----------------HDFS-------------------------

# Selektieren des Working Directories für hadoop
cd hdfs_data_lake

# Starten des Hadoop Clusters
echo "Start Hadoop Cluster"
bash startHDFS.sh

# Auf home dir wechseln
cd ..

# -----------------Spark-----------------------

# Selektieren des Working Directories für data/spark
cd data

# Starten von Spark
echo "Start Spark Cluster and operation"
bash startSpark.sh

# bash streaming/submitStreaming.sh
# bash streaming/submitKafka.sh


# Auf home dir wechseln
cd ..

kubectl get all

echo "Starting completed"