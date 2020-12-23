#!/bin/bash

# ---------------Kafka------------------------------
cd data/kafka
echo "Delete Kafka"
bash deleteKafka.sh
cd ../..

# --------------- Web ---------------------------

# Selektieren des Working Directories für die web app
cd app

# Stoppen des Web Clusters
echo "Delete Web Cluster"
bash deleteWeb.sh

# Auf home dir wechseln
cd ..

# ------------------ HDFS ----------------------

# Selektieren des Working Directories für hadoop
cd hdfs_data_lake

# Stoppen des Hadoop Clusters
echo "Delete Hadoop Cluster"
bash deleteHDFS.sh

# Auf home dir wechseln
cd ..

# ------------------- Spark ------------------------

# Selektieren des Working Directories für spark/data
cd data

# Stoppen des spark/data Clusters
echo "Delete Spark Cluster"
bash deleteAllSparkpods.sh

# Auf home dir wechseln
cd ..

kubectl get all

echo "Deletion finished"