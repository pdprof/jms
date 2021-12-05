#!/bin/bash

docker run --network pdprof-network --name mq -p 1414:1414 -d mq
