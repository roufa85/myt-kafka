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

## MYT Demo

1. Ensure that the setup up and running and that Prom, Grafana are acessible
2. Run Docker compose for Kafka Manager and ZooNavigator

```
cd github.com/roufa85/myt-kafka && code .
vagrant up --provision
sudo docker-compose -f docker-compose/kafka-manager.yml up -d
sudo docker-compose -f docker-compose/zoonavigator.yml up -d
```

3. Open these links into your browser:
	- Prometheus to verify Targets: http://192.168.2.110:9090/targets
	- Grafana to see Kafka Overview Dashboard (Username & password: kafka): http://192.168.2.110:3000/d/9H312vsZk/kafka-overview?orgId=1&refresh=5s
	- Kafka Manager to add new cluster using ZK_HOST variable: http://localhost:9000/addCluster
	- ZooNavigator to add new connection using using ZK_HOST variable: http://localhost:7070/connect

`ZK_HOST: 192.168.2.110:2181,192.168.2.111:2181,192.168.2.112:2181/kafka`

```

google-chrome http://192.168.2.110:9090/targets
google-chrome http://192.168.2.110:3000/d/9H312vsZk/kafka-overview?orgId=1&refresh=5s
google-chrome http://localhost:9000/addCluster
google-chrome http://localhost:7070/connect
```

---

1. Create a first test topic with 3 partitions and 1 replicas
```
vagrant ssh node0
cd /vagrant/scripts
bash ./topic.sh
```
2. Show Kafka Manager about the topics config
3. Show ZooNavigator about cluster config (brokers and topic test)

---

1. Open Console Producer and produce 3 records, we expect that each consumer will read a message
```
vagrant ssh node1
cd /vagrant/scripts
bash ./producer.sh
```
2. Open 3 Console Consumer and specify a consumer group to read from topic test
```
vagrant ssh node2
cd /vagrant/scripts
bash ./consumer.sh
```
3. Open a 4th Console consumer, this later should be idle !!

---

1. Change topic test replication factor to 2, see the config in Kafka Manager
2. Run Producer to produce messages
3. At the same time, stop kafka service in one broker. Then have a look at monitoring
4. Go to Kafka dir: /data/kafka/ to see the the log segements !
---