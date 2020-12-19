#!/bin/bash
hadoopIp=$(kubectl describe service/knox-apache-knox-helm-svc | grep "IP:" | grep -E -o '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)')
echo "Hadoop IP: ${hadoopIp}"

path="http://"${hadoopIp}":8080/webhdfs/v1/data/data.csv?op=CREATE&permission=664"
location=$(curl -i -k -u admin:admin-password -X PUT "${path}" | grep "Location: " | grep -E -o 'http?://[^ ]+' | sed 's/\r//g')
curl -i -k -u admin:admin-password -T ../../collection/dataset.csv ${location}