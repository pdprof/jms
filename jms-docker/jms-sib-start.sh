#!/bin/bash
if [ ! -d ~/pdprof ]; then
    mkdir ~/pdprof
fi
docker run -d --name sib --network pdprof-network -v ~/pdprof:/pdprof jms-sib
