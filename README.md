# cdh_cluster

1. Make sure you have docker install and running

$ docker pull dfossouo/cdh-namenode

$ docker pull dfossouo/cdh-yarnmaster

$ docker pull dfossouo/cdh-datanode

2. Create CDH Network

$ docker network create cdh_network

3. Start HDFS

$ docker run -d --net cdh_network --net-alias cdh-namenode -p 8020:8020 dfossouo/cdh-namenode

4. Start YARN

$ docker run -d --net cdh_network --net-alias cdh-yarnmaster -p 8088:8088 -p 8032:8032 dfossouo/cdh-yarnmaster

5. Start DataNode 

$ docker run -d --net cdh_network --net-alias cdh-datanode --link cdh-namenode --link yarnmaster -p 50020:50020 -p 50075:50075 -p 8042:8042 dfossouo/cdh-datanode

6. Launch Edge Node 

$ docker run -ti --net cdh_network --net-alias cdh-edge --link cdh-namenode --link cdh-yarnmaster dfossouo/cdh-edge bash
