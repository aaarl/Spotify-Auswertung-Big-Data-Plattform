from pyspark.streaming import StreamingContext
from pyspark.sql import Row, SparkSession
from pyspark import SparkContext
import socketserver
import threading
import time
import random

# Define server thread
def start_server_thread():
    class MySocketHandler(socketserver.BaseRequestHandler):
        def handle(self):
            # List with all artists available in dataset.csv/ compressed in artists.csv
            artists = ["Anuel AA", "Ariana Grande", "Ava Max", "Bad Bunny", "Beyoncé", "Billie Eilish", "Black Eyed Peas", "Bruno Mars", "Calvin Harris", "Camila Cabello", "Coldplay", "DaBaby", "Daddy Yankee", "David Guetta", "Diplo", "Doja Cat", "Drake", "Dua Lipa", "Ed Sheeran", "Eminem", "Halsey", "Harry Styles", "Imagine Dragons", "Imanbek", "J Balvin", "Jason Derulo", "Jawsh 685", "Juice WRLD", "Justin Bieber", "Kanye West", "Katy Perry", "Khalid", "Kygo", "Lady Gaga", "Lewis Capaldi", "Maroon 5", "Marshmello", "Nicki Minaj", "OneRepublic", "Ozuna", "Post Malone", "Queen", "Rihanna", "Saint Jhn", "Sam Smith", "Selena Gomez", "Shawn Mendes", "Sia", "Swae Lee", "Taylor Swift", "The Chainsmokers", "The Weeknd", "Tones and I", "Travis Scott", "Tyga"]
            # Endless loop to always create new random data
            while True:
                # Create a new record with a random country and a random number between 1 and 10
                line = random.choice(countries) + " " + str(random.randint(1,10)) + "\n"
                # Encode the data and send them
                self.request.sendall(line.encode("UTF-8"))
                # Turn the thread to sleep for 0.5 seconds. This can be changed as needed
                time.sleep(0.5)
            # Close the request 
            self.request.close()

    # Create TCPServer and serve forever 
    socketserver.TCPServer(("127.0.0.1", 1234), MySocketHandler).serve_forever()
# Start thread
threading.Thread(target=start_server_thread, daemon=True).start()




# Get spark session 
def getSparkSessionInstance(sparkConf):
    if ('sparkSessionSingletonInstance' not in globals()):
        globals()['sparkSessionSingletonInstance'] = SparkSession\
            .builder\
            .config(conf=sparkConf)\
            .getOrCreate()
    return globals()['sparkSessionSingletonInstance']




# Function to save a rdd to the database
def saveToDb(rdd):
    # Get the configuration 
    conf = rdd.context.getConf()
    # Get the spark session
    sparkSession = getSparkSessionInstance(conf)
    # Convert the rdd to a row rdd
    rowRdd = rdd.map(lambda w: Row(country=w[0], count=w[1]))
    # Create a data frame from the row rdd
    wordsDataFrame = sparkSession.createDataFrame(rowRdd)
    
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



# Create spark context
sc = SparkContext("local[*]", "DStream Example")
# Create streaming context with an interval of 10 seconds
ssc = StreamingContext(sc, 10)
# Read the incoming records
lines = ssc.socketTextStream("127.0.0.1", 1234)

# Transform data as needed
data = lines\
        .map(lambda line: line.split(" "))\
        .map(lambda word: (word[0], int(word[1])))\
        .reduceByKey(lambda x, y: x + y)
# Handle each rdd and save it to the database
data.foreachRDD(saveToDb)

# Start the computation and wait for termination
ssc.start()
ssc.awaitTermination()
