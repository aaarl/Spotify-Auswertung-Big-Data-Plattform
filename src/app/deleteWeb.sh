#!/bin/bash

# todo af: check the delete queries!

# Delete the web app pods / services
echo "Delete the web app"

echo "deployment/memcache-deployment"
kubectl delete deployment/memcache-deployment

echo "deployment/my-super-app-deployment"
kubectl delete deployment/my-super-app-deployment

echo "deployment/mysql-deployment"
kubectl delete deployment/mysql-deployment

echo "svc/my-super-app-service"
kubectl delete svc/my-super-app-service

echo "svc/my-memcached-service"
kubectl delete svc/my-memcached-service

echo "svc/my-database-service"
kubectl delete svc/my-database-service

echo "ingress/my-super-app-ingress"
kubectl delete ingress/my-super-app-ingress

# Check it's shutting down
echo "Check it's shutting down"
#watch kubectl get all