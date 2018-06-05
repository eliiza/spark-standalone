#!/bin/bash
/usr/local/spark/sbin/start-slave.sh $1
tail -f /usr/local/spark/logs/*
