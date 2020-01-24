# MixYourTalent - Apache Kafka


Prerequisite:

```
$ vagrant plugin install vagrant-vbguest 
```

Spin-up & Provision:

```
$ vagrant up --provision
```

Prometheus: http://192.168.2.111:9090/graph
Grafana: http://192.168.2.111:3000/ (Username & password: kafka)

Debug:

```
$ vagrant ssh controller
```

```
[vagrant@localhost vagrant]$ cd /vagrant
[vagrant@localhost vagrant]$ ansible-playbook provision/common.yml -i inventory 
```

Create Topic:
```
$ vagrant ssh node1
[vagrant@localhost ~]$ /opt/kafka/bin/kafka-topics.sh --zookeeper zookeeper1:2181/kafka --create --topic test --replication-factor 1 --partitions 3
[vagrant@localhost ~]$ /opt/kafka/bin/kafka-topics.sh --zookeeper zookeeper1:2181/kafka --topic test --describe
```

Admin Tools UI:

```
$ sudo docker-compose -f docker-compose/kafka-manager.yml up -d
$ sudo docker-compose -f docker-compose/zoonavigator.yml up -d
```

ZK_HOST: 192.168.2.111:2181

Kafka Manager: http://192.168.2.111:9000/ | http://localhost:9000/
ZooNavigator: http://192.168.2.111:7070/ | http://localhost:7070/