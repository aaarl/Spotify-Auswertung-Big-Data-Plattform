#!/bin/bash
"true" '''\' #allow running from vs code, cf. http://rosettacode.org/wiki/Multiline_shebang#Python
CUR_DIR="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
CUR_FILE=`basename "$0"`
CMD="docker run -it --rm -v \"$PWD/data:/data\" -v \"$CUR_DIR:/src\" --name=pyspark jupyter/pyspark-notebook spark-submit \"/src/$CUR_FILE\" | grep -v INFO"
echo "Running: $CMD" | sed "s|$PWD|\$PWD|g"
eval "$CMD"
exit 0
'''

# BEGIN-SNIPPET
from pyspark import SparkContext, SQLContext
from pyspark.sql import functions as F

inputFile = "hdfs://my-hadoop-cluster-hadoop-hdfs-nn:9000/data/dataset.csv"
output = "hdfs://my-hadoop-cluster-hadoop-hdfs-nn:9000/result/testing.csv"
# Create local Spark Context
spark = SparkContext("local[*]", "SQL_Example")
sc = SQLContext(spark)

# The following creates a DataFrame based on the content of a JSON file
df = sc.read.load(inputFile, format="csv", sep=",",
                  inferSchema="true", header="true")
#df = sc.read.load("../../collection/dataset.csv", format="csv", sep=",", inferSchema="true", header="true")

# Test Display of dateRep column
df.select("date").show()

# Displays the content of the DataFrame to stdout

# Print the schema in a tree format
df.printSchema()

sum = df.groupBy('name').agg(
    F.max('total_timesListened').alias('total_tests'),
) \
    .orderBy('total_tests', ascending=False) \

sum.show()

sum.coalesce(1).write.csv(path=output, mode="overwrite")

sum.write.option("truncate", "true").format("jdbc") \
    .option("url", "jdbc:mysql://my-database-service:3306/spotifydb") \
    .option("dbtable", "testing") \
    .option("user", "root") \
    .option("password", "mysecretpw") \
    .mode("overwrite") \
    .save()
