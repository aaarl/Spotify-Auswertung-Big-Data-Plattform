#!/bin/bash

# Minikube ingress Add-on freischalten
echo "Activate minikube ingress add-on"
minikube addons enable ingress

# Setzen des Docker Build Kontextes auf Minikube
echo "Set docker build context to minikube"
eval $(minikube docker-env --shell bash)

# Bauen des Applikationsimages aus dem Dockerfile
echo "Build the application image of the docker file"
cd app-web
docker build -t my-super-web-app .
cd ..

# Bauen des Databaseimages aus dem Dockerfile
echo "Build the database image of the docker file"
cd database
docker build -t my-super-mysql-database .
cd ..

# Ausführen der YAML-Dateien mit Bauanleitung der Infrastruktur
echo "Apply instructions to kubernetes to build the necessary infrasructure"

echo "Step 1: mysql.yml"
kubectl apply -f mysql.yml

echo "Step 2: service.yml"
kubectl apply -f service.yml

echo "Step 3: memcached.yml"
kubectl apply -f memcached.yml

echo "Step 4: deployment.yml"
kubectl apply -f deployment.yml

# Überprüfen, ob die Applikation läuft
echo "Check it's running"
kubectl get ingress -o wide

echo "Wait for ingress"
sleep 3

#watch kubectl get all