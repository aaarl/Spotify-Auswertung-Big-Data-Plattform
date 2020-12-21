#!/bin/bash

# ------------------ Hadoop IP ------------------------------------------------------

hadoopIp=$(kubectl describe service/knox-apache-knox-helm-svc | grep "IP:" | grep -E -o '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)')
hadoopIp=127.0.0.1
echo "Hadoop IP: ${hadoopIp}"

# ------------------ Batch ----------------------------------------------------------

# path="http://"${hadoopIp}":8080/webhdfs/v1/app/writeToDatabase.py?op=DELETE"
# curl -i -k -u admin:admin-password -X DELETE "${path}"

path="http://"${hadoopIp}":8080/webhdfs/v1/app/writeToDatabase.py?op=CREATE&permission=664"
echo "Path: ${path}"
location=$(curl -i -k -u admin:admin-password -X PUT "${path}" | grep "Location: " | grep -E -o 'http?://[^ ]+')
echo Location: ${location}

clean=$(echo "$location" | sed 's/\r//g')
echo Clean: ${clean}

echo -i -k -u admin:admin-password -T batch/writeToDatabase.py ${clean}
curl -i -k -u admin:admin-password -T batch/writeToDatabase.py ${clean}

# ------------------ Spark Streaming ----------------------------------------------------------
path="http://"${hadoopIp}":8080/webhdfs/v1/app/sparkStreaming.py?op=DELETE"
curl -i -k -u admin:admin-password -X DELETE "${path}"

path="http://"${hadoopIp}":8080/webhdfs/v1/app/sparkStreaming.py?op=CREATE&permission=664"
location=$(curl -i -k -u admin:admin-password -X PUT "${path}" | grep "Location: " | grep -E -o 'http?://[^ ]+')

clean=$(echo "$location" | sed 's/\r//g')

curl -i -k -u admin:admin-password -T streaming/sparkStreaming.py ${clean}


# ------------------ Kafka Streaming ----------------------------------------------------------
path="http://"${hadoopIp}":8080/webhdfs/v1/app/kafkaStream.py?op=DELETE"
curl -i -k -u admin:admin-password -X DELETE "${path}"

path="http://"${hadoopIp}":8080/webhdfs/v1/app/kafkaStream.py?op=CREATE&permission=664"
location=$(curl -i -k -u admin:admin-password -X PUT "${path}" | grep "Location: " | grep -E -o 'http?://[^ ]+')

clean=$(echo "$location" | sed 's/\r//g')

curl -i -k -u admin:admin-password -T streaming/kafkaStream.py ${clean}

