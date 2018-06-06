#!/bin/bash
/usr/local/spark/sbin/start-slave.sh $@
tail -f /usr/local/spark/logs/*
