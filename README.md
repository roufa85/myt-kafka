# MixYourTalent - Apache Kafka


## Prerequisite:

```
$ vagrant plugin install vagrant-vbguest 
```

## Spin-up & Provision:

```
$ vagrant up --provision
```

* Prometheus: http://192.168.2.110:9090/graph
* Grafana: http://192.168.2.110:3000/ (Username & password: kafka)

## Debug:

```
$ vagrant ssh controller
```

```
[vagrant@localhost vagrant]$ cd /vagrant
[vagrant@localhost vagrant]$ ansible-playbook -i ansible/inventory -v ansible/hosts.yml
```

## Create Topic:

```
$ vagrant ssh node1
[vagrant@localhost ~]$ /opt/kafka/bin/kafka-topics.sh --zookeeper node0:2181/kafka --create --topic test --replication-factor 1 --partitions 3
[vagrant@localhost ~]$ /opt/kafka/bin/kafka-topics.sh --zookeeper node0:2181/kafka --topic test --describe
```

## Admin Tools UI:

```
$ sudo docker-compose -f docker-compose/kafka-manager.yml up -d
$ sudo docker-compose -f docker-compose/zoonavigator.yml up -d
```

`ZK_HOST: 192.168.2.110:2181,192.168.2.111:2181,192.168.2.112:2181/kafka`

* Kafka Manager: http://localhost:9000/
* ZooNavigator: http://localhost:7070/