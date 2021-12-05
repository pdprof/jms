#!/bin/bash
network=`docker network ls | grep pdprof-network | wc -l`
if test $network -lt 1; then
    docker network create pdprof-network
fi

# Setup for MQ
docker build -t mq -f Dockerfile.mq .
sed s/localhost/mq/g config/server.xml.jms-mq > config/server.xml
docker build -t jms-mq -f Dockerfile.jms-mq .
rm config/server.xml

# Setup for SIBus
docker build -t jms-sib -f Dockerfile.jms-sib .
sed s/localhost/sib/g config/server.xml.jms-sib-client > config/server.xml
docker build -t jms-sib-client -f Dockerfile.jms-sib-client .
rm config/server.xml

# Setup for ActiveMQ
sed s/localhost/amq/g config/server.xml.jms-amq > config/server.xml
docker build -t jms-amq -f Dockerfile.jms-amq .
rm config/server.xml
