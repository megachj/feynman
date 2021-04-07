# 1. debezium 사용자에게 권한을 부여한다.
GRANT SELECT, RELOAD, SHOW DATABASES, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO `debezium`@`%` IDENTIFIED BY 'debeziumpw';

# 2. 예제 DB, TABLES 스키마 작성 및 dummy data 생성.
CREATE DATABASE moneydb;
GRANT ALL PRIVILEGES ON moneydb.* TO 'debezium'@'%';

USE moneydb;

CREATE TABLE user (
  user_id bigint(20) NOT NULL AUTO_INCREMENT,
  name varchar(100) NOT NULL,
  created_at datetime DEFAULT NOW(),
  PRIMARY KEY (user_id)
);
ALTER TABLE user AUTO_INCREMENT = 1;

INSERT INTO user (name, created_at)
VALUES
('ext_user1', '2020-01-01'),
('ext_user2', '2020-01-01'),
('ext_user3', '2020-01-01'),
('ext_user4', '2020-01-01'),
('ext_user5', '2020-01-01');

CREATE TABLE tx_event (
  tx_id bigint(20) NOT NULL AUTO_INCREMENT,
  user_id bigint(20) NOT NULL,
  target_id bigint(20) NOT NULL,
  type enum('CHARGE', 'SEND', 'RECEIVE') NOT NULL,
  amount int(11) NOT NULL,
  created_at datetime DEFAULT NOW(),
  PRIMARY KEY (tx_id, created_at),
  KEY created_at_idx (created_at)
);
ALTER TABLE tx_event AUTO_INCREMENT = 1001;

# 월별 파티셔닝
ALTER TABLE tx_event PARTITION BY RANGE (TO_DAYS(created_at)) (
  PARTITION p_2020_01 VALUES LESS THAN (TO_DAYS('2020-02-01')),
  PARTITION p_2020_02 VALUES LESS THAN (TO_DAYS('2020-03-01')),
  PARTITION p_2020_03 VALUES LESS THAN (TO_DAYS('2020-04-01')),
  PARTITION p_max VALUES LESS THAN MAXVALUE
); 

INSERT INTO tx_event (user_id, target_id, type, amount, created_at)
VALUES
(1, 1, 'CHARGE', 10000, '2020-01-02'),
(1, 2, 'SEND', 10000, '2020-01-02'),
(2, 1, 'RECEIVE', 10000, '2020-01-02'),
(3, 3, 'CHARGE', 20000, '2020-01-03'),
(3, 4, 'SEND', 10000, '2020-01-03'),
(3, 5, 'SEND', 10000, '2020-01-03'),
(4, 3, 'RECEIVE', 10000, '2020-01-03'),
(5, 3, 'RECEIVE', 10000, '2020-01-03');

INSERT INTO tx_event (user_id, target_id, type, amount, created_at)
VALUES
(1, 1, 'CHARGE', 10000, '2020-02-02'),
(1, 2, 'SEND', 10000, '2020-02-02'),
(2, 1, 'RECEIVE', 10000, '2020-02-02'),
(3, 3, 'CHARGE', 20000, '2020-02-03');

INSERT INTO tx_event (user_id, target_id, type, amount, created_at)
VALUES
(1, 1, 'CHARGE', 10000, '2020-03-02'),
(1, 2, 'SEND', 10000, '2020-03-02'),
(2, 1, 'RECEIVE', 10000, '2020-03-02'),
(3, 3, 'CHARGE', 20000, '2020-03-03');