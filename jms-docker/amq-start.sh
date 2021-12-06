#!/bin/bash
docker run --name amq -p 61616:61616 -p 8161:8161 -d rmohr/activemq
