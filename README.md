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

Admin Tools UI:

```
$ docker-compose -f docker-compose/kafka-manager.yml up -d
$ docker-compose -f docker-compose/zoonavigator.yml up -d
```

ZK_HOST: 192.168.2.111:2181

Kafka Manager: http://192.168.2.111:3000/ | http://localhost:3000/
ZooNavigator: http://192.168.2.111:7070/ | http://localhost:7070/