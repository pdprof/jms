#!/bin/bash
if [ ! -d ~/pdprof ]; then
    mkdir ~/pdprof
fi
docker run -d --name jms-amq --network pdprof-network -p 9443:9443 -p 9080:9080 -v ~/pdprof:/pdprof jms-amq
