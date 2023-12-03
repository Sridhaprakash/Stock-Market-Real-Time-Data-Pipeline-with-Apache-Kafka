from confluent_kafka import Consumer, KafkaError

# Specify your Kafka broker address
bootstrap_servers = 'localhost:9092'

# Kafka consumer configuration
conf = {
    'bootstrap.servers': bootstrap_servers,
    'group.id': 'python-consumer',
    'auto.offset.reset': 'earliest'  # Use 'earliest' to consume all messages from the beginning
}

# Create a Kafka consumer instance
consumer = Consumer(conf)

# Subscribe to the desired topic
consumer.subscribe(['stock_data_topic'])

try:
    while True:
        # Poll for messages
        msg = consumer.poll(1.0)  # Adjust the timeout based on your needs

        if msg is None:
            continue
        if msg.error():
            if msg.error().code() == KafkaError._PARTITION_EOF:
                # End of partition event - not an error
                continue
            else:
                print("Consumer error: {}".format(msg.error()))
                break

        # Print the received message value
        print('Received message: {}'.format(msg.value().decode('utf-8')))

except KeyboardInterrupt:
    pass
finally:
    # Close down consumer to commit final offsets.
    consumer.close()
