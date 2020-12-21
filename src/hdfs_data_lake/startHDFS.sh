#! /bin/bash
helm repo add stable https://charts.helm.sh/stable --force-update
helm install --namespace=default --set hdfs.dataNode.replicas=3 --set yarn.nodeManager.replicas=3 --set hdfs.webhdfs.enabled=true my-hadoop-cluster stable/hadoop

echo "Waiting some time until everything loaded properly ..."
sleep 30
echo "Still waiting ..."
sleep 30
echo "Still waiting ..."
sleep 30
echo "Still waiting ..."
sleep 30
echo "-------------------------"
kubectl get all

# link to repo: https://github.com/pfisterer/apache-knox-helm
helm repo add pfisterer-knox https://pfisterer.github.io/apache-knox-helm/
helm install \
        --set "knox.hadoop.nameNodeUrl=hdfs://my-hadoop-cluster-hadoop-hdfs-nn:9000/"  \
        --set "knox.hadoop.resourceManagerUrl=http://my-hadoop-cluster-hadoop-yarn-rm:8088/ws" \
        --set "knox.hadoop.webHdfsUrl=http://my-hadoop-cluster-hadoop-hdfs-nn:50070/webhdfs/" \
        --set "knox.hadoop.hdfsUIUrl=http://my-hadoop-cluster-hadoop-hdfs-nn:50070" \
        --set "knox.hadoop.yarnUIUrl=http://my-hadoop-cluster-hadoop-yarn-ui:8088" \
        --set "knox.servicetype=LoadBalancer" \
        knox pfisterer-knox/apache-knox-helm

echo "---- helm: repo list ----"
helm repo list
echo "--- helm: list --all ----"
helm list --all
echo "--- kubectl: get all ----"
kubectl get all

bash startLoad.sh
