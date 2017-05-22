# /bin/bash



# 1. Make sure you have docker install and running

docker pull dfossouo/cloudera-namenode:5.9.0

docker pull dfossouo/cloudera-yarn:5.9.0

docker pull dfossouo/cloudera-datanode:5.9.0

docker pull dfossouo/cloudera-edge:5.9.0

# 2. Create CDH Network

docker network create cloudera_network

#3. Start HDFS

docker run -d --net cloudera_network --net-alias cdh-namenode -p 8020:8020 dfossouo/cloudera-namenode:5.9.0

#4. Start YARN

docker run -d --net cloudera_network --net-alias cdh-yarnmaster -p 8088:8088 -p 8032:8032 dfossouo/cloudera-yarn:5.9.0

#5. Start DataNode

docker run -d --net cloudera_network --net-alias cdh-datanode -h cdh-datanode --link cloudera-namenode --link yarnmaster -p 50020:50020 -p 50075:50075 -p 8042:8042 dfossouo/cloudera-datanode:5.9.0 

#6. Launch Edge Node

docker run -ti --net cloudera_network --net-alias cdh-edge --link cdh-namenode --link cloudera-yarnmaster dfossouo/cloudera-edge:5.9.0 bash
