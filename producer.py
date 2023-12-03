from confluent_kafka import Producer, KafkaError
import yfinance as yf
from time import sleep
from json import dumps

# Specify your Kafka broker address
bootstrap_servers = '<Your Public IP>:9092'

# Kafka producer configuration
conf = {
    'bootstrap.servers': bootstrap_servers,
    'client.id': 'python-producer'
}

# Create a Kafka producer instance
producer = Producer(conf)

# Ticker symbol for the stock you want to track
ticker_symbol = 'AAPL'

while True:
    try:
        # Fetch live stock data using yfinance
        stock_data = yf.Ticker(ticker_symbol).info
        # Extract relevant information from the stock data
        sample_data = {
            'symbol': stock_data['symbol'],
            'name': stock_data['shortName'],
            'price': stock_data['ask'],
            'timestamp': stock_data['regularMarketTime']
        }
        
        # Send the data to Kafka
        producer.produce('stock_data_topic', value=dumps(sample_data).encode('utf-8'))
        sleep(1)  # Adjust the sleep duration based on your requirements
    except Exception as e:
        print("An error occurred while fetching or sending data:", e)

    # Check for any delivery reports from Kafka
    msg = producer.poll(1.0)
    if msg is not None:
        if msg.error():
            if msg.error().code() == KafkaError._PARTITION_EOF:
                # End of partition event - not an error
                continue
            else:
                print("Producer error: {}".format(msg.error()))
        else:
            print("Message delivered to {} [{}]".format(msg.topic(), msg.partition()))

# Close the producer
producer.flush()
producer.close()
