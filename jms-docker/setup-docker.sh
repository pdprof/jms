#!/bin/bash
# if docker is used, you can use docker network
#network=`docker network ls | grep pdprof-network | wc -l`
#if test $network -lt 1; then
#    docker network create pdprof-network
#fi

DOCKER_HOST=192.168.122.1

# Setup for MQ
docker build -t mymq -f Dockerfile.mq .
sed s/localhost/$DOCKER_HOST/g config/server.xml.jms-mq > config/server.xml
docker build -t jms-mq -f Dockerfile.jms-mq .
rm config/server.xml

# Setup for SIBus
docker build -t jms-sib -f Dockerfile.jms-sib .
sed s/localhost/$DOCKER_HOST/g config/server.xml.jms-sib-client > config/server.xml
docker build -t jms-sib-client -f Dockerfile.jms-sib-client .
rm config/server.xml

# Setup for ActiveMQ
sed s/localhost/$DOCKER_HOST/g config/server.xml.jms-amq > config/server.xml
docker build -t jms-amq -f Dockerfile.jms-amq .
rm config/server.xml
