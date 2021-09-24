#!/bin/bash
docker build -t mymq -f Dockerfile.mq .

#[mqm@8fdb356b7891 /]$ setmqaut -m QM0 -t qmgr -p myuser +connect +inq +dsp
#The setmqaut command completed successfully.
#[mqm@8fdb356b7891 /]$ setmqaut -m QM0 -n '**' -t q -p myuser +dsp +browse
#The setmqaut command completed successfully.
#[mqm@8fdb356b7891 /]$ setmqaut -m QM0 -n '**' -t topic -p myuser +dsp +pub +sub
#[mqm@8fdb356b7891 /]$ setmqaut -m QM0 -n '**' -t channel -p myuser +dsp
#[mqm@8fdb356b7891 /]$ setmqaut -m QM0 -t queue -n QM0.LQ0 -p johedoe +allmqi
#[mqm@8fdb356b7891 /]$ etmqaut -m QM0 -t queue -n QM0.LQ1 -p myuser +allmqi
# alt authinfo(DEV.AUTHINFO) CHCKCLNT(OPTIONAL) AUTHTYPE(IDPWOS)
# ALTER QMGR CHLAUTH (DISABLED)
# REFRESH SECURITY TYPE(CONNAUTH)

