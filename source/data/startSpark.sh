#!/bin/bash

# Setup Spark
echo "Setup Spark"
kubectl create serviceaccount spark
kubectl create clusterrolebinding spark-role --clusterrole=edit --serviceaccount=default:spark --namespace=default

# Build the docker image
echo "Build docker image pyspark-k8s"
docker build -t pyspark-k8s .

# Configure Hadoop
echo "Configure Hadoop, open remote bash"
#kubectl exec -it my-hadoop-cluster-hadoop-hdfs-nn-0 -- /bin/bash

echo "Configure Hadoop, creating folders"
kubectl exec -it my-hadoop-cluster-hadoop-hdfs-nn-0 -- hdfs dfs -mkdir hdfs://my-hadoop-cluster-hadoop-hdfs-nn:9000/tmp/
kubectl exec -it my-hadoop-cluster-hadoop-hdfs-nn-0 -- hdfs dfs -mkdir hdfs://my-hadoop-cluster-hadoop-hdfs-nn:9000/data
kubectl exec -it my-hadoop-cluster-hadoop-hdfs-nn-0 -- hdfs dfs -mkdir hdfs://my-hadoop-cluster-hadoop-hdfs-nn:9000/app
kubectl exec -it my-hadoop-cluster-hadoop-hdfs-nn-0 -- hdfs dfs -mkdir hdfs://my-hadoop-cluster-hadoop-hdfs-nn:9000/result
echo "Configure Hadoop, creating folders - DONE"

echo "Configure Hadoop, changing folder access rights"
kubectl exec -it my-hadoop-cluster-hadoop-hdfs-nn-0 -- hdfs dfs -chmod -R 777 hdfs://my-hadoop-cluster-hadoop-hdfs-nn:9000/tmp/
kubectl exec -it my-hadoop-cluster-hadoop-hdfs-nn-0 -- hdfs dfs -chmod -R 777 hdfs://my-hadoop-cluster-hadoop-hdfs-nn:9000/data
kubectl exec -it my-hadoop-cluster-hadoop-hdfs-nn-0 -- hdfs dfs -chmod -R 777 hdfs://my-hadoop-cluster-hadoop-hdfs-nn:9000/app
kubectl exec -it my-hadoop-cluster-hadoop-hdfs-nn-0 -- hdfs dfs -chmod -R 777 hdfs://my-hadoop-cluster-hadoop-hdfs-nn:9000/result
echo "Configure Hadoop, changing folder access rights - DONE"

echo "Completed Hadoop Setup, starting to load data into the Database"
# Update the data
# echo "Update the data"
# cd ../../collection
# bash updateData.sh
# cd ../source/data

bash updateScript.sh
bash uploadData.sh

bash batch/submitData.sh
echo "Completed Hadoop Setup, starting to load data into the Database - DONE"

cd streaming && bash startStreaming.sh
