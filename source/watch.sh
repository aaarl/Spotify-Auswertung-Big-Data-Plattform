#!/bin/bash

# this acts as a heartbeat for the minikube status since there have been some issues under win 10 home
for (( ; ; ))
do
minikube status
sleep 3
done