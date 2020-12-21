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
kubectl exec -it my-hadoop-cluster-hadoop-hdfs-nn-0 -- hdfs dfs -mkdir hdfs://my-hadoop-cluster-hadoop-hdfs-nn:9000/tmp/
kubectl exec -it my-hadoop-cluster-hadoop-hdfs-nn-0 -- hdfs dfs -mkdir hdfs://my-hadoop-cluster-hadoop-hdfs-nn:9000/data
kubectl exec -it my-hadoop-cluster-hadoop-hdfs-nn-0 -- hdfs dfs -mkdir hdfs://my-hadoop-cluster-hadoop-hdfs-nn:9000/app
kubectl exec -it my-hadoop-cluster-hadoop-hdfs-nn-0 -- hdfs dfs -mkdir hdfs://my-hadoop-cluster-hadoop-hdfs-nn:9000/result
kubectl exec -it my-hadoop-cluster-hadoop-hdfs-nn-0 -- hdfs dfs -chmod -R 777 hdfs://my-hadoop-cluster-hadoop-hdfs-nn:9000/tmp/
kubectl exec -it my-hadoop-cluster-hadoop-hdfs-nn-0 -- hdfs dfs -chmod -R 777 hdfs://my-hadoop-cluster-hadoop-hdfs-nn:9000/data
kubectl exec -it my-hadoop-cluster-hadoop-hdfs-nn-0 -- hdfs dfs -chmod -R 777 hdfs://my-hadoop-cluster-hadoop-hdfs-nn:9000/app
kubectl exec -it my-hadoop-cluster-hadoop-hdfs-nn-0 -- hdfs dfs -chmod -R 777 hdfs://my-hadoop-cluster-hadoop-hdfs-nn:9000/result

# Update the data
# echo "Update the data"
# cd ../../collection
# bash updateData.sh
# cd ../src/data

bash updateScript.sh
bash uploadData.sh

bash batch/submit.sh

cd streaming && bash startStreaming.sh
