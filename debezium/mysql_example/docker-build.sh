#!/bin/bash
docker build -t megachj/debezium.mysql_example:1.0 .

# docker hub push
# 로컬에서 빌드 후, $ docker push megachj/debezium.mysql_example:1.0