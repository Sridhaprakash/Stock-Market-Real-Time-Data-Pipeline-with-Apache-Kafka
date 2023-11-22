In linux to the directory - 
cd /mnt/c/users/sridh/downloads/kafka_2.13-3.6.0

# Start ZooKeeper
bin/zookeeper-server-start.sh config/zookeeper.properties

# Start Kafka Server in a separate terminal window
bin/kafka-server-start.sh config/server.properties

# Create a topic named "demo_test"
bin/kafka-topics.sh --create --topic demo_test --bootstrap-server localhost:9092  #create topic
bin/kafka-topics.sh --create --topic demo_test --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1
bin/kafka-topics.sh --describe --topic demo_test --bootstrap-server localhost:9092

# Start a Kafka producer and consumer in separate terminal windows
bin/kafka-console-producer.sh --topic demo_test --bootstrap-server localhost:9092
bin/kafka-console-consumer.sh --topic demo_test --from-beginning --bootstrap-server localhost:9092

