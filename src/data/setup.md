# Install Anaconda
* https://www.anaconda.com/products/individual

# Install Spark
* Needed to run spark-submit
* https://www.apache.org/dyn/closer.lua/spark/spark-2.4.5/spark-2.4.5-bin-hadoop2.7.tgz
* Extract file
* Add to .bashrc:
```
export SPARK_HOME=/opt/spark
export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin
export PYSPARK_PYTHON=python
export PYSPARK_DRIVER_PYTHON=python
export PYSPARK_DRIVER_PYTHON_OPTS=""
```
* ```source .bashrc```

# Setup K8s
```
$ kubectl create serviceaccount spark
$ kubectl create clusterrolebinding spark-role --clusterrole=edit --serviceaccount=default:spark --namespace=default
```
# Build Dockerfile
```
$ docker build -t pyspark-k8s .
```

# Configure Hadoop
```
$ kubectl exec -it my-hadoop-cluster-hadoop-hdfs-nn-0 -- /bin/bash
hadoop# hdfs dfs -mkdir hdfs://my-hadoop-cluster-hadoop-hdfs-nn:9000/tmp/
hadoop# hdfs dfs -mkdir hdfs://my-hadoop-cluster-hadoop-hdfs-nn:9000/data
hadoop# hdfs dfs -mkdir hdfs://my-hadoop-cluster-hadoop-hdfs-nn:9000/app
hadoop# hdfs dfs -mkdir hdfs://my-hadoop-cluster-hadoop-hdfs-nn:9000/result
hadoop# hdfs dfs -chmod -R 777 hdfs://my-hadoop-cluster-hadoop-hdfs-nn:9000/tmp/
hadoop# hdfs dfs -chmod -R 777 hdfs://my-hadoop-cluster-hadoop-hdfs-nn:9000/data
hadoop# hdfs dfs -chmod -R 777 hdfs://my-hadoop-cluster-hadoop-hdfs-nn:9000/app
hadoop# hdfs dfs -chmod -R 777 hdfs://my-hadoop-cluster-hadoop-hdfs-nn:9000/result
```

# Upload data
```
$ curl -i -k -u admin:admin-password -X PUT 'http://{hadoop-ip}:8080/webhdfs/v1/data/data.csv?op=CREATE&permission=664'
$ curl -i -k -u admin:admin-password -T data.csv {location value vom ersten request}
$ curl -i -k -u admin:admin-password -X PUT 'http://{hadoop-ip}:8080/webhdfs/v1/data/testingData.csv?op=CREATE&permission=664'
$ curl -i -k -u admin:admin-password -T testingData.csv {location value vom ersten request}
```

# Upload script to hadoop
```
$ sh updateScript.sh

```

# Run scripts
```
$ kubectl exec -it my-hadoop-cluster-hadoop-hdfs-nn-0 -- /bin/bash
hadoop# hdfs dfs -rm -r hdfs://my-hadoop-cluster-hadoop-hdfs-nn:9000/result/result2.csv
hadoop# exit
$ Normal shell: sh submit.sh
```

# Get result (csv)
http://{hadoop-ip}:8080/gateway/sandbox/hdfs/explorer.html

 
# Check pod
```
$ kubectl get pods
$ kubectl logs {pod}
```

# Check Database
```
$ kubectl exec -ti mysql-deployment-6d469897cc-tc9sw -- /bin/bash
mysql# mysql -u root -p coronadb --password=mysecretpw
mysql> SELECT * FROM sums;
```
