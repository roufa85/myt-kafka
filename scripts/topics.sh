#!/bin/bash
 

for i in $(seq 1 9)
do
    /opt/kafka/bin/kafka-topics.sh \
        --create \
        --zookeeper node0:2181/kafka \
        --topic test"_p${i}_r1" \
        --partitions ${i} \
        --replication-factor 1    
done

for i in $(seq 1 9)
do
    /opt/kafka/bin/kafka-topics.sh \
        --create \
        --zookeeper node0:2181/kafka \
        --topic test"_p${i}_r2" \
        --partitions ${i} \
        --replication-factor 2     
done

for i in $(seq 1 9)
do
    /opt/kafka/bin/kafka-topics.sh \
        --create \
        --zookeeper node0:2181/kafka \
        --topic test"_p${i}_r2" \
        --partitions ${i} \
        --replication-factor 3
done