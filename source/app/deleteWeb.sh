#!/bin/bash
echo "Delete the web app"

echo "deployment/my-memcached"
kubectl delete deployment/my-memcached

echo "deployment/my-super-app-deployment"
kubectl delete deployment/my-super-app-deployment

echo "deployment/mysql-deployment"
kubectl delete deployment/mysql-deployment

echo "svc/my-super-app-service"
kubectl delete svc/my-super-app-service

echo "svc/my-memcached"
kubectl delete svc/my-memcached

echo "svc/my-database-service"
kubectl delete svc/my-database-service

echo "ingress/my-super-app-ingress"
kubectl delete ingress/my-super-app-ingress

# Check it's shutting down
echo "Check it's shutting down"
#watch kubectl get all
