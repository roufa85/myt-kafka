#!/bin/bash

/opt/kafka/bin/kafka-console-producer.sh --broker-list node-0:9092,node-1:9092,node-2:9092 --topic test < input.txt



