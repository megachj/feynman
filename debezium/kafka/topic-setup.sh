# kafka connect 용 토픽 생성
/kafka/bin/kafka-topics.sh --zookeeper zookeeper:2181/kafka --replication-factor 1 --partitions 1 --topic connect.configs --create
/kafka/bin/kafka-topics.sh --zookeeper zookeeper:2181/kafka --replication-factor 1 --partitions 1 --topic connect.offsets --create
/kafka/bin/kafka-topics.sh --zookeeper zookeeper:2181/kafka --replication-factor 1 --partitions 1 --topic connect.statuses --create

/kafka/bin/kafka-configs.sh --zookeeper zookeeper:2181/kafka --alter --entity-type topics --entity-name connect.configs  --add-config cleanup.policy=compact
/kafka/bin/kafka-configs.sh --zookeeper zookeeper:2181/kafka --alter --entity-type topics --entity-name connect.offsets  --add-config cleanup.policy=compact
/kafka/bin/kafka-configs.sh --zookeeper zookeeper:2181/kafka --alter --entity-type topics --entity-name connect.statuses --add-config cleanup.policy=compact

# debezium source connector 용 토픽 생성
/kafka/bin/kafka-topics.sh --zookeeper zookeeper:2181/kafka --replication-factor 1 --partitions 3 --topic moneydb_server --create
/kafka/bin/kafka-topics.sh --zookeeper zookeeper:2181/kafka --replication-factor 1 --partitions 3 --topic moneydb_server.dbhistory-money --create
/kafka/bin/kafka-topics.sh --zookeeper zookeeper:2181/kafka --replication-factor 1 --partitions 3 --topic moneydb_server.moneydb.user --create
/kafka/bin/kafka-topics.sh --zookeeper zookeeper:2181/kafka --replication-factor 1 --partitions 3 --topic moneydb_server.moneydb.tx_event --create
