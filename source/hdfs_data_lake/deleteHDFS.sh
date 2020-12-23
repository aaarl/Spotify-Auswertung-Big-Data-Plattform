#! /bin/bash
echo "Deleting deployments"
kubectl delete deployment.apps/knox-apache-knox-helm-dep

echo "Deleting services"
kubectl delete service/my-hadoop-cluster-hadoop-hdfs-dn
kubectl delete service/my-hadoop-cluster-hadoop-hdfs-nn
kubectl delete service/my-hadoop-cluster-hadoop-yarn-nm
kubectl delete service/my-hadoop-cluster-hadoop-yarn-rm
kubectl delete service/my-hadoop-cluster-hadoop-yarn-ui
kubectl delete service/knox-apache-knox-helm-svc

echo "Deleting statefulsets"
kubectl delete statefulset.apps/my-hadoop-cluster-hadoop-hdfs-dn
kubectl delete statefulset.apps/my-hadoop-cluster-hadoop-hdfs-nn
kubectl delete statefulset.apps/my-hadoop-cluster-hadoop-yarn-nm 
kubectl delete statefulset.apps/my-hadoop-cluster-hadoop-yarn-rm

echo "Deleting helm repo and release"
helm repo remove stable
helm delete my-hadoop-cluster
helm repo remove pfisterer-knox
helm delete knox

helm repo list
helm list --all
kubectl get all
