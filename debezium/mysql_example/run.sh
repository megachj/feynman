#!/bin/bash

docker run -dit --name mysql_example -p 3306:3306 --network debezium-docker-net -e MYSQL_ROOT_PASSWORD=root -e MYSQL_USER=debezium -e MYSQL_PASSWORD=debeziumpw megachj/debezium.mysql_example:1.0