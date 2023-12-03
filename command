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

#View the Logs in Real-Time 
tail -f server.log

#Specifies the partitioner class to be used for partitioning messages. The RoundRobinPartitioner is used here, meaning that messages will be assigned to partitions in a round-robin fashion.
bin/kafka-console-producer.sh --topic demo_test --property "key.serializer=org.apache.kafka.common.serialization.StringSerializer" --property "partitioner.class=org.apache.kafka.clients.producer.RoundRobinPartitioner" --bootstrap-server localhost:9092

#creating consumer grp
bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic demo_test --group group1


1. creat a docker-compose.yml file
2. run- docker compose -f docker-compose.yml up -d
3. docker images
4. docker ps  - docker process status
5. docker exec -it <kafka_conatiner_id> /bin/sh




