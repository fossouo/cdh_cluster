# cloudera_cluster

1. Make sure you have docker install and running

$ docker pull dfossouo/cloudera-namenode:5.9.0
$ docker pull dfossouo/cloudera-yarn:5.9.0
$ docker pull dfossouo/cloudera-datanode:5.9.0
$ docker pull dfossouo/cloudera-edge:5.9.0

2. Create CDH Network

$ docker network create cloudera_network

3. Start HDFS

$ docker run -d --net cloudera_network --net-alias cloudera-namenode -p 8020:8020 dfossouo/cloudera-namenode:5.9.0

4. Start YARN

$ docker run -d --net cloudera_network --net-alias cloudera-yarnmaster -p 8088:8088 -p 8032:8032 dfossouo/cloudera-yarn:5.9.0

5. Start DataNode 

$ docker run -d --net cloudera_network --net-alias cloudera-datanode -h datanode --link cloudera-namenode --link cloudera-yarn -p 50020:50020 -p 50075:50075 -p 8042:8042 dfossouo/cloudera-datanode:5.9.0

6. Launch Edge Node 

$ docker run -ti --net cloudera_network --net-alias cloudera-edge --link cloudera-namenode --link cloudera-yarn dfossouo/cloudera-edge:5.9.0 bash
