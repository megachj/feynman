FROM debezium/connect:1.4
LABEL MAINTAINER="sunset.choe"

# 환경 변수 설정
ENV TZ=Asia/Seoul
ENV BOOTSTRAP_SERVERS=kafka:9092
ENV GROUP_ID=mysql-source-connector-group
ENV CONFIG_STORAGE_TOPIC=sunset_connect.configs
ENV OFFSET_STORAGE_TOPIC=sunset_connect.offsets
ENV STATUS_STORAGE_TOPIC=sunset_connect.statuses
ENV OFFSET_FLUSH_TIMEOUT_MS=60000
