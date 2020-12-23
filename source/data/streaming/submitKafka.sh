spark-submit \
    --master k8s://https://$(minikube ip):8443 \
    --deploy-mode cluster \
    --name spark-kafka \
    --conf spark.executor.instances=1 \
    --conf spark.kubernetes.container.image=pyspark-k8s \
    --conf spark.kubernetes.authenticate.driver.serviceAccountName=spark \
    --conf spark.kubernetes.pyspark.pythonVersion=3 \
    --conf spark.kubernetes.authenticate.driver.serviceAccountName=spark \
    hdfs://my-hadoop-cluster-hadoop-hdfs-nn:9000/app/kafkaStream.py
