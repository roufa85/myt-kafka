#!/bin/bash


zpid=`ps ax | grep -i 'org.apache.zookeeper' | grep -v grep | awk '{print $1}'`
if [ -n "$zpid" ]
    then
    echo "zookeeper is already running"
else
    sudo service zookeeper start
fi


kpid=`ps ax | grep -i 'kafka.Kafka' | grep -v grep | awk '{print $1}'`
if [ -n "$kpid" ]
    then
    echo "Kafka is already running"
else
    sudo service kafka start
fi