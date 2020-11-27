FROM csturm/spark-py:v2.4.5
COPY mysql.jar /opt/spark/jars
COPY kafkaSql.jar /opt/spark/jars
COPY kafkaStreaming.jar /opt/spark/jars
COPY . /app
WORKDIR /app
