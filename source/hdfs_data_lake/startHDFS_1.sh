#! /bin/bash
helm repo add stable https://charts.helm.sh/stable --force-update
helm install --namespace=default --set hdfs.webhdfs.enabled=true my-hadoop-cluster stable/hadoop

echo "Waiting some time until everything loaded properly ..."

for (( ; ; ))
do
kubectl get all
sleep 15
done