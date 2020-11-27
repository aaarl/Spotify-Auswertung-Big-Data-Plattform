# Start Spark Streaming
nohup bash submitStreaming.sh 2000 1>/dev/null 2>/dev/null &

# Stark Spark Structured Streaming
nohup bash submitKafka.sh 2000 1>/dev/null 2>/dev/null &
