#!/bin/bash
 

/opt/kafka/bin/kafka-topics.sh \
    --zookeeper node0:2181/kafka \
    --create \
    --topic test \
    --replication-factor 1 \
    --partitions 3