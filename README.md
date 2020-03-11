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

## Tear-down

In case you want to stop the VMs on your local machine:

```
$ vagrant halt
```

If you want to clean-up the whole VMs:
```
$ vagrant destroy --force
```

## Debug:

Make your local changes, then run the command `vagrant rsync` to get the files synced, then connect to `node-0` in a separate terminal:

```
$ vagrant ssh node-0
[vagrant@localhost vagrant]$ cd /vagrant/ansible
[vagrant@localhost vagrant]$ ansible-playbook -i inventory -v hosts.yml
```

## Create Topic:

### PLAINTEXT

```
$ vagrant ssh node-0
[vagrant@node-0 ansible]$ /opt/kafka/bin/kafka-topics.sh --zookeeper node-0:2181/kafka --create --topic test --replication-factor 1 --partitions 3
[vagrant@node-0 ansible]$ /opt/kafka/bin/kafka-topics.sh --zookeeper node-0:2181/kafka --topic test --describe
[vagrant@node-0 ansible]$ /opt/kafka/bin/kafka-console-producer.sh --broker-list node-0:9092,node-1:9092,node-2:9092 --topic test
[vagrant@node-0 ansible]$ /opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server node-0:9092,node-1:9092,node-2:9092 --topic test --from-beginning #group.id=test1
```

### SSL

We will use the same test topic and produced data:

```
vagrant ssh node-0
[vagrant@node-0 ansible]$ /opt/kafka/bin/kafka-console-producer.sh --broker-list node-0:9093,node-1:9093,node-2:9093 --topic test --producer.config /vagrant/scripts/client.properties 
[vagrant@node-0 ansible]$ /opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server node-0:9093,node-1:9093,node-2:9093 --topic test --from-beginning --consumer.config /vagrant/scripts/client.properties #group.id=test1
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
vagrant ssh node-0
cd /vagrant/scripts
bash ./topic.sh
```
2. Show Kafka Manager about the topics config
3. Show ZooNavigator about cluster config (brokers and topic test)

---

1. Open Console Producer and produce 3 records, we expect that each consumer will read a message
```
vagrant ssh node-1
cd /vagrant/scripts
bash ./producer.sh
```
2. Open 3 Console Consumer and specify a consumer group to read from topic test
```
vagrant ssh node-2
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