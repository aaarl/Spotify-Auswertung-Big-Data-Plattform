from pyspark import SparkContext, SQLContext
from pyspark.sql import functions as F

spark = SparkContext("local[*]", "SQL_Example")
sc = SQLContext(spark)

df = sc.read.load("hdfs://my-hadoop-cluster-hadoop-hdfs-nn:9000/data/dataset.csv",
                  format="csv",
                  sep=",",
                  inferSchema="true",
                  header="true")

sum = df.groupBy('artist').agg(
    F.sum('timesListened').alias('timesListened')) \
    .orderBy('timesListened', ascending=True)

sum.show()

sum.write.option("truncate", "true").format("jdbc") \
    .option("url", "jdbc:mysql://my-database-service:3306/spotifydb") \
    .option("dbtable", "live_spotify") \
    .option("user", "root") \
    .option("password", "mysecretpw") \
    .mode("overwrite") \
    .save()
