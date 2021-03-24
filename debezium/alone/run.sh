#!/bin/bash
docker run -dit --name debezium_alone --network debezium-docker-net -p 8085:8083 debezium_alone
