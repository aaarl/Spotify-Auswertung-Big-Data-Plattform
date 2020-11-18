# TODO AF

from pyspark import SparkContext, SQLContext

spark = SparkContext("local[*]", "SQL_Example")
sc = SQLContext(spark)

dataFrame = sc.read.load("../test/dataset.csv", format="csv",
                         sep=";", inferSchema="true", header="true")

# to test dateRep column
dataFrame.select("dateRep").show()
dataFrame.show()
dataFrame.printSchema()

# todo af
sum = dataFrame.groupBy('I need a code from the db here') \
               .sum('timesListened') \
               .orderBy('sum(cases)', ascending=False)

sum.show()

# todo af: rename db
sum.write \
    .format("jdbc") \
    .option("url", "jdbc:mysql://my-app-mysql-service:33060/sportsdb") \
    .option("dbtable", "totalTimesListened") \
    .option("user", "root") \
    .option("password", "mysecretpw") \
    .save()
