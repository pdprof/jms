# JMS Application

## Requirements

- [Docker](https://www.docker.com/)

## Test on Docker

### Build docker image

```
vi setup-docker.sh # Edit DOCKER_HOST ip address for your environment
./setup-docker.sh
```

### Start docker 

To start JMS servers (ActiveMQ, IBM MQ, WebSphere Liberty SIBus)

```
./amq-start.sh
./mq-start.sh
./jms-sib-start.sh
```

To start JMS client for each server. All jms server use 9080 and 9443 ports. Please stop liberty before to start another server.

```
mkdir ~/pdprof
./jms-amq-start.sh
./jms-mq-start.sh
./jms-sib-client-start.sh
```

Now you can access http://localhost:9080/jms/


## Test on OpenShift

After you setup CRC described at [icp4a-helloworld](https://github.com/pdprof/icp4a-helloworld)

You can use following script. 
```
setup-openshift.sh
```

Now you can access to follow URLs.

- [ActiveMQ client](http://jms-amq-route-default.apps-crc.testing/jms/)
- [IBM MQ client](http://jms-mq-route-default.apps-crc.testing/jms/)
- [SIBus client](http://jms-sib-client-route-default.apps-crc.testing/jms/)

Other test steps are same with docker.
