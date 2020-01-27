#!/bin/bash

/opt/kafka/bin/kafka-console-consumer.sh \
     --bootstrap-server node0:9092,node1:9092,node2:9092 \
     --topic test \
     --from-beginning \
     --consumer-property group.id=test1