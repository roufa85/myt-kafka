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
Grafana: http://192.168.2.111:3000/ 

Debug:

```
$ vagrant ssh controller
```

```
[vagrant@localhost vagrant]$ cd /vagrant/provision/
[vagrant@localhost vagrant]$ ansible-playbook provision/common.yml -i inventory 
```