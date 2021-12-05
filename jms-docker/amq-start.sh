#!/bin/bash
docker run --network pdprof-network --name amq -p 6161:61616 -p 8161:8161 -d rmohr/activemq
