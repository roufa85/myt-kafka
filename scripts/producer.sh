#!/bin/bash

/opt/kafka/bin/kafka-producer-perf-test.sh \
  --num-records 100 \
  --record-size 1000 \
  --topic test \
  --throughput 1000 \
  --producer-props bootstrap.servers=node0:9092,node1:9092,node2:9092 \
    acks=0