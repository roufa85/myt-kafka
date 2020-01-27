#!/bin/bash

/opt/kafka/bin/kafka-producer-perf-test.sh \
  --num-records 100 \
  --record-size 1000 \
  --topic test \
  --throughput 1000 \
  --producer-props bootstrap.servers=192.168.2.110:9092,192.168.2.111:9092,192.168.2.112:9092 \
    acks=0