#!/bin/bash

/opt/kafka/bin/kafka-console-producer.sh --broker-list node0:9092,node1:9092,node2:9092 --topic test < input.txt



