#!/bin/bash
setmqaut -m QM0 -t qmgr -p myuser +connect +inq +dsp
setmqaut -m QM0 -n '**' -t q -p myuser +dsp +browse
setmqaut -m QM0 -n '**' -t topic -p myuser +dsp +pub +sub
setmqaut -m QM0 -n '**' -t channel -p myuser +dsp
setmqaut -m QM0 -t queue -n QM0.LQ0 -p myuser +allmqi
setmqaut -m QM0 -t queue -n QM0.LQ1 -p myuser +allmqi
