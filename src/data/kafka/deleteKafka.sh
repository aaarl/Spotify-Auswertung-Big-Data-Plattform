#!/bin/bash

echo "Deleting Kafka Cluster services"
kubectl delete service/my-kafka-cluster-kafka-bootstrap
kubectl delete service/my-kafka-cluster-kafka-brokers
kubectl delete service/my-kafka-cluster-zookeeper-client
kubectl delete service/my-kafka-cluster-zookeeper-nodes

echo "Deleting Kafka Cluster deployments"
kubectl delete deployment.apps/my-kafka-cluster-entity-operator

echo "Deleting statefulsets"
kubectl delete statefulset.apps/my-kafka-cluster-kafka
kubectl delete statefulset.apps/my-kafka-cluster-zookeeper

# Uninstall the kafka operator to stop kafka
echo "Unistall the kafka operator"
helm repo remove strimzi
helm delete my-kafka-operator

kubectl get all
