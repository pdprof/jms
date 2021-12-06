#!/bin/bash
if [ ! -d ~/pdprof ]; then
    mkdir ~/pdprof
fi
docker run -d --name sib -p 7276:7276 -p 7286:7286 -v ~/pdprof:/pdprof jms-sib
