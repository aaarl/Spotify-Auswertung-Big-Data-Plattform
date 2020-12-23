from pyspark.streaming import StreamingContext
from pyspark.sql import Row, SparkSession
from pyspark import SparkContext
import socketserver
import threading
import time
import random

# Define server thread


def startServerThread():
    class MySocketHandler(socketserver.BaseRequestHandler):
        def handle(self):
            # List with all artists available in dataset.csv/ compressed in artists.csv
            artists = ["Anuel AA", "Ariana Grande", "Ava Max", "Bad Bunny", "Beyoncé", "Billie Eilish", "Black Eyed Peas", "Bruno Mars", "Calvin Harris", "Camila Cabello", "Coldplay", "DaBaby", "Daddy Yankee", "David Guetta", "Diplo", "Doja Cat", "Drake", "Dua Lipa", "Ed Sheeran", "Eminem", "Halsey", "Harry Styles", "Imagine Dragons", "Imanbek", "J Balvin", "Jason Derulo", "Jawsh 685",
                       "Juice WRLD", "Justin Bieber", "Kanye West", "Katy Perry", "Khalid", "Kygo", "Lady Gaga", "Lewis Capaldi", "Maroon 5", "Marshmello", "Nicki Minaj", "OneRepublic", "Ozuna", "Post Malone", "Queen", "Rihanna", "Saint Jhn", "Sam Smith", "Selena Gomez", "Shawn Mendes", "Sia", "Swae Lee", "Taylor Swift", "The Chainsmokers", "The Weeknd", "Tones and I", "Travis Scott", "Tyga"]
            # Create new random data
            while True:
                # Random artists and a random number between 1 and 10
                line = random.choice(artists) + "###" + \
                    str(random.randint(1, 10)) + "\n"
                self.request.sendall(line.encode("UTF-8"))
                time.sleep(1)
            self.request.close()

    # Create TCPServer and serve forever
    socketserver.TCPServer(("127.0.0.1", 1234),
                           MySocketHandler).serve_forever()


# Start thread
threading.Thread(target=startServerThread, daemon=True).start()

# Get spark session


def getSparkSessionInstance(sparkConf):
    if ('sparkSessionSingletonInstance' not in globals()):
        globals()['sparkSessionSingletonInstance'] = SparkSession\
            .builder\
            .config(conf=sparkConf)\
            .getOrCreate()
    return globals()['sparkSessionSingletonInstance']


# Function to save a dataCollection to the database
def saveToDatabase(dataCollection):
    # Get the configuration
    conf = dataCollection.context.getConf()
    # Get the spark session
    sparkSession = getSparkSessionInstance(conf)
    # Convert the dataCollection to a row dataCollection
    rowDataCollection = dataCollection.map(
        lambda w: Row(artist=w[0], count=w[1]))
    # Create a data frame from the row dataCollection
    wordsDataFrame = sparkSession.createDataFrame(rowDataCollection)

    # Show the data frame - for debugging
    # wordsDataFrame.show()
    # Print the schema of the data frame - for debugging
    # wordsDataFrame.printSchema()

    # Write the data frame to the database
    wordsDataFrame.write\
        .mode("append") \
        .format("jdbc") \
        .option("driver", "com.mysql.jdbc.Driver") \
        .option("url", "jdbc:mysql://my-database-service:3306/spotifydb") \
        .option("dbtable", "live_spotify") \
        .option("user", "root") \
        .option("password", "mysecretpw") \
        .save()


sparkContext = SparkContext("local[*]", "DStream Example")
streamingContext = StreamingContext(sparkContext, 10)
# Read the incoming records
lines = streamingContext.socketTextStream("127.0.0.1", 1234)

# Example of handling:
# Justin Bieber###2
# Justin Bieber###3
# Justin Bieber###6
# Justin Bieber###9
#
# Celine Dion###6
# Celine Dion###3
#

# Transform data as needed
data = lines\
    .map(lambda line: line.split("###"))\
    .map(lambda word: (word[0], int(word[1])))\
    .reduceByKey(lambda x, y: x + y)
# Example of handling:
# [{'JustinBieber': 20}, {'Celine Dior': 9}]

# Handle each dataCollection and save it to the database
data.foreachRDD(saveToDatabase)

# Start the computation and wait for termination
streamingContext.start()
streamingContext.awaitTermination()
