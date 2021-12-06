#!/bin/bash

# prereq : oc login is required to execuete this shell
#          trapit program and shell PATH environment variable to execute it.
#          kubeadmin
#curl -O https://www.ibm.com/support/pages/system/files/support/swg/swgtech.nsf/0/d83af3cb5f0490d1852579d600618374/$FILE/trapit.002/trapit
#if [ ! -f trapit ]; then
#     echo "===================="
#     echo "Please download trapit from https://www.ibm.com/support/pages/node/709009 and put it on the same directory."
#     echo "====================" 
#     exit 1
#fi
#chmod 755 trapit

$HOME/kubeadmin

oc registry login
docker login `oc registry info`

# pull openliberty docker repository
BUILD_DATE=`date +%Y%m%d`

# Setup for MQ
docker build -t mymq -f Dockerfile.mq .
sed s/localhost/mq-service.$(oc project -q).svc.cluster.local/g config/server.xml.jms-mq > config/server.xml
docker build -t jms-mq -f Dockerfile.jms-mq .
rm config/server.xml

# Setup for SIBus
docker build -t jms-sib -f Dockerfile.jms-sib .
sed s/localhost/sib-service.$(oc project -q).svc.cluster.local/g config/server.xml.jms-sib-client > config/server.xml
docker build -t jms-sib-client -f Dockerfile.jms-sib-client .
rm config/server.xml

# Setup for ActiveMQ
docker pull rmohr/activemq:latest
sed s/localhost/amq-service.$(oc project -q).svc.cluster.local/g config/server.xml.jms-amq > config/server.xml
docker build -t jms-amq -f Dockerfile.jms-amq .
rm config/server.xml

docker tag mymq:latest $(oc registry info)/$(oc project -q)/mymq:${BUILD_DATE}
docker tag jms-mq:latest $(oc registry info)/$(oc project -q)/jms-mq:${BUILD_DATE}
docker tag jms-sib:latest $(oc registry info)/$(oc project -q)/jms-sib:${BUILD_DATE}
docker tag jms-sib-client:latest $(oc registry info)/$(oc project -q)/jms-sib-client:${BUILD_DATE}
docker tag rmohr/activemq:latest $(oc registry info)/$(oc project -q)/amq:${BUILD_DATE}
docker tag jms-amq:latest $(oc registry info)/$(oc project -q)/jms-amq:${BUILD_DATE}

docker push $(oc registry info)/$(oc project -q)/mymq:${BUILD_DATE}
docker push $(oc registry info)/$(oc project -q)/jms-mq:${BUILD_DATE}
docker push $(oc registry info)/$(oc project -q)/jms-sib:${BUILD_DATE}
docker push $(oc registry info)/$(oc project -q)/jms-sib-client:${BUILD_DATE}
docker push $(oc registry info)/$(oc project -q)/amq:${BUILD_DATE}
docker push $(oc registry info)/$(oc project -q)/jms-amq:${BUILD_DATE}

sed s/image-registry.openshift-image-registry.svc:5000/default-route-openshift-image-registry.apps-crc.testing/g kubernetes.yaml.org > kubernetes.yaml
sed s/"\[project-name\]"/$(oc project -q)/g kubernetes.yaml
sed s/"\[build-date\]"/${BUILD_DATE}/g kubernetes.yaml

oc create secret generic docker-user-secret --from-file=.dockerconfigjson=$HOME/.docker/config.json --type=kubernetes.io/dockerconfigjson
oc apply -f kubernetes.yaml
rm kubernetes.yaml
