#!/bin/bash

/opt/kafka/bin/kafka-console-consumer.sh \
     --bootstrap-server node-0:9092,node-1:9092,node-2:9092 \
     --topic test \
     --from-beginning \
     --consumer-property group.id=test1