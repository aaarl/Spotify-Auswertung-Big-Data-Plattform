#! /bin/bash

echo "Start loading Data in HDFS"

echo "Create input folder and load data"
kubectl exec -ti my-hadoop-cluster-hadoop-yarn-rm-0 -- bash -c "hdfs dfs -mkdir -p input && hdfs dfs -chmod -R 777 input && cat ./collection/dataset.csv | hdfs dfs -put - input/spotifydata"

echo "List folder 'input'"
kubectl exec -ti my-hadoop-cluster-hadoop-yarn-rm-0 -- bash -c "hdfs dfs -ls input"

echo "Loading data completed"

echo "Get IP of the load balancer"
KNOX_IP=`kubectl get svc knox-apache-knox-helm-svc \
        '-o=jsonpath={.status.loadBalancer.ingress[0].ip}'`
echo $KNOX_IP

kubectl describe service/knox-apache-knox-helm-svc
echo "1) Check application at KNOX Endpoint IP: "
echo "> http://KNOX_IP:8080/yarn/"
echo "> http://KNOX_IP:8080/hdfs/"
echo "2) Use the following login credentials: "
echo "> User: admin"
echo "> PW: admin-password"
echo "3) Access Data Lake via WebHDFS REST API"
echo "> List a directory: curl -v -u admin:admin-password 'http://KNOX_IP:8080/webhdfs/v1/user/root/input/?op=LISTSTATUS'"
echo "> Read and open file: curl -v -u admin:admin-password -i -L 'http://KNOX_IP:8080/webhdfs/v1/user/root/input/spotifydata?op=OPEN'"
