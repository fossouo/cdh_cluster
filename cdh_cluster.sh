# /bin/bash



# 1. Make sure you have docker install and running

docker pull dfossouo/cdh-namenode:5.9.0

docker pull dfossouo/cdh-yarnmaster:5.9.0

docker pull dfossouo/cloudera-datanode:5.9.0

docker pull dfossouo/cloudera-edge:5.9.0

# 2. Create CDH Network

docker network create cloudera-network

#3. Start HDFS

docker run -d --net cloudera-network --net-alias cdh-namenode -p 8020:8020 dfossouo/cloudera-namenode:5.9.0

#4. Start YARN

docker run -d --net cloudera-network --net-alias cdh-yarn -p 8088:8088 -p 8032:8032 dfossouo/cloudera-yarn:5.9.0

#5. Start DataNode

docker run -d --net cloudera-network --net-alias cloudera-datanode-1 -h datanode_1 --link cdh-namenode --link cdh-yarn -p 50020:50020 -p 50075:50075 -p 8042:8042 dfossouo/cloudera-datanode:5.9.0
docker run -d --net cloudera-network --net-alias cloudera-datanode-2 -h datanode_2 --link cdh-namenode --link cdh-yarn -p 50021:50020 -p 50076:50075 -p 8043:8042 dfossouo/cloudera-datanode:5.9.0
docker run -d --net cloudera-network --net-alias cloudera-datanode-3 -h datanode_3 --link cdh-namenode --link cdh-yarn -p 50022:50020 -p 50077:50075 -p 8044:8042 dfossouo/cloudera-datanode:5.9.0
#6. Launch Edge Node

docker run -ti --net cloudera-network --net-alias cloudera-edge --link cdh-namenode --link cdh-yarn dfossouo/cloudera-edge:5.9.0 bash
