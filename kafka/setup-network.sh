#!bin/bash
docker network create --gateway 172.255.0.1 --subnet 172.255.0.0/16 kafka-docker-net
