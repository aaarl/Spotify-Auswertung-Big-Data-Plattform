#!/bin/bash
pod_name=$(kubectl get pods --no-headers -o custom-columns=":metadata.name" | grep mysql)
echo $pod_name
kubectl exec -i $pod_name -- mysql -u root -p spotifydb --password=mysecretpw -e 'DROP TABLE live_spotify;'

spark-submit \
    --master k8s://https://$(minikube ip):8443 \
    --deploy-mode cluster \
    --name spark-batch \
    --conf spark.executor.instances=1 \
    --conf spark.kubernetes.container.image=pyspark-k8s \
    --conf spark.kubernetes.authenticate.driver.serviceAccountName=spark \
    --conf spark.kubernetes.pyspark.pythonVersion=3 \
    hdfs://my-hadoop-cluster-hadoop-hdfs-nn:9000/app/writeToDatabase.py
