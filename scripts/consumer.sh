#!/bin/bash

/opt/kafka/bin/kafka-consumer-perf-test.sh  \
     --messages 100 \
     --topic test \
     --fetch-size 100 \
     --broker-list node0:9092,node1:9092,node2:9092