from pyspark import SparkConf, SparkContext
from pyspark.sql import SparkSession
from pyspark.sql.functions import explode, split

# Create a function to write each batch to the database
def foreachBatch(dataframe, _id):
    dataframe.write\
        .mode("overwrite") \
        .format("jdbc") \
        .option("truncate", "true") \
        .option("driver", "com.mysql.jdbc.Driver") \
        .option("url", "jdbc:mysql://my-database-service:3306/spotifydb") \
        .option("dbtable", "web_requests") \
        .option("user", "root") \
        .option("password", "mysecretpw") \
        .save()    

if __name__ == "__main__":

    # Due to some issue, we have to instantiate a new SparkConf and SparkContext, even if it is not used directly. The SparkSession is trying to create a new SparkContext and fails if we don't do it before manually.
    conf = SparkConf().setAppName("test_import")
    sc = SparkContext("local[*]", "DStream Example")

    # Create new SparkSession in order to read from Kafka
    spark = SparkSession.builder.config(conf=conf).getOrCreate()
    # Change the log level to WARN, as otherwise Spark is showing the Kafka offset on every request, when no new data is available
    spark.sparkContext.setLogLevel("WARN")

    # Create DataSet representing the stream of input lines from kafka
    # By using "startingOffsets" = "earliest", we will fetch all available data from the Kafka topic
    lines = spark.readStream \
        .format("kafka") \
        .option("kafka.bootstrap.servers", "my-kafka-cluster-kafka-bootstrap:9092") \
        .option("subscribe", "web-requests") \
        .option("startingOffsets", "earliest") \
        .load()

    # Split the lines into words
    words = lines.select(
        lines.value.alias("url")
    )

    # Generate running word count
    wordCounts = words.groupBy("url").count()

    # Start running the query 
    query = wordCounts \
        .writeStream \
        .outputMode("complete") \
        .foreachBatch(foreachBatch) \
        .start()

    query.awaitTermination()
