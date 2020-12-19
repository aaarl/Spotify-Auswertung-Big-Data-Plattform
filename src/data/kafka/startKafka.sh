#!/bin/bash

# Add strimzi operator
echo "Add strimzi repo"
helm repo add strimzi http://strimzi.io/charts/

# Installieren des kafka operators
echo "Install Kafka operator"
helm install my-kafka-operator strimzi/strimzi-kafka-operator

# Wait for operator to start
echo "Wait till everything is configured properly"
sleep 15

# Deployen des clusters durch den operator
echo "Deploy cluster"
kubectl apply -f 01-kafka-cluster-def.yml

echo "Deploy topic web-requests"
kubectl apply -f 02-kafka-topic-web-requests.yml

# watch kubectl get all
