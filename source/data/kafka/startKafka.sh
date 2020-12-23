#!/bin/bash
echo "Add strimzi repo"
helm repo add strimzi https://strimzi.io/charts/

echo "Install Kafka operator"
helm install my-kafka-operator strimzi/strimzi-kafka-operator

echo "Wait till everything is configured properly"
sleep 15

echo "Deploy cluster"
kubectl apply -f 01-kafka-cluster-def.yml

echo "Deploy topic web-requests"
kubectl apply -f 02-kafka-topic-web-requests.yml