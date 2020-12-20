# BEGIN-SNIPPET
from pyspark import SparkContext, SQLContext
from pyspark.sql import functions as F
# Input Data from HDFS
inputFile = "hdfs://my-hadoop-cluster-hadoop-hdfs-nn:9000/data/dataset.csv"
output = "hdfs://my-hadoop-cluster-hadoop-hdfs-nn:9000/result/result2.csv"
# Create local Spark Context
spark = SparkContext("local[*]", "SQL_Example")
sc = SQLContext(spark)

# Read the csv files from HDFS
df = sc.read.load(inputFile, format="csv", sep=",",
                  inferSchema="true", header="true")
# For local testing (Note: install pyspark - pip install pyspark):
#df = sc.read.load("../../collection/dataset.csv", format="csv", sep=",", inferSchema="true", header="true")

# Aggregate the Artists and Release date from the artists, join other information by using the max aggregation function
sum = df.groupBy('countryterritoryCode').agg(
    F.sum('artists').alias('total_artists'),
    F.sum('month').alias('total_cases'),
    F.max('timesListened').alias('timesListened'),
    F.max('year').alias('alpha2'),
    F.max('mostStreamedSong').alias('name'),
    F.max('genre').alias('genre')
) \
    .orderBy('total_artists', ascending=False) \

sum.show()

# Write dataframe to database
# Overwrite Data if already existing
output.write.option("truncate", "true").format("jdbc") \
    .option("url", "jdbc:mysql://my-database-service:3306/spotifydb") \
    .option("dbtable", "spotify_artists") \
    .option("user", "root") \
    .option("password", "mysecretpw") \
    .mode("overwrite") \
    .save()
