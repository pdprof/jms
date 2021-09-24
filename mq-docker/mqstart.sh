#!/bin/bash
docker run --name mq --env LICENSE=accept --env MQ_QMGR_NAME=QM0 -p 1414:1414 -d mymq
