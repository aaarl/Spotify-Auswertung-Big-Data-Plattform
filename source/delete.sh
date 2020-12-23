#!/bin/bash

# Kafka
cd data/kafka
echo "Delete Kafka"
bash deleteKafka.sh
cd ../..

# Web
cd app
echo "Delete Web Cluster"
bash deleteWeb.sh
cd ..

# HDFS
cd hdfs_data_lake

echo "Delete Hadoop Cluster"
bash deleteHDFS.sh
cd ..

# Spark
cd data
echo "Delete Spark Cluster"
bash deleteAllSparkpods.sh
cd ..

kubectl get all

echo "Deletion finished"