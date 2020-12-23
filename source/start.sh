#!/bin/bash

# Kafka
cd data/kafka/
echo "Start Kafka"
bash startKafka.sh
cd ../..

# Web
cd app
echo "Start Web Cluster"
bash startWeb.sh
cd ..

# HDFS
cd hdfs_data_lake
echo "Start Hadoop Cluster"
bash startHDFS.sh
cd ..

# Spark
cd data
echo "Start Spark Cluster and operation"
bash startSpark.sh

# If this is necessary
# bash streaming/submitStreaming.sh
# bash streaming/submitKafka.sh

cd ..

kubectl get all

echo "Starting completed"