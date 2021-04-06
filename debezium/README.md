# 실행 방법
## 도커 컴포즈 실행
```sh
# 1. 도커 네트워크 설정
docker network ls # 도커 네트워크 조회
sh ./setup-network.sh # debezium-docker-net 이 없다면 네트워크 셋업

# 2. 도커 컴포즈 실행
docker-compose up -d --build

# 3. 도커 컴포즈 종료
docker-compose down
```

## debezium mysql connector 등록
```sh
# 컨테이너가 실행 중인 상태에서 호출
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" localhost:8083/connectors/ -d @mysql-source-connector.json
```

## 기타
### akhq
브라우저에서 localhost:8080 접속

### grafana
1. 브라우저에서 localhost:3000 접속, admin/admin 으로 로그인.
2. MySQL Connector 대시보드 접속해서 dashboard variables 를 업데이트 해준다.  
'Dashboard settings -> Variables' 각 variable 들을 하나씩 들어가서 update 버튼을 눌러준다.
(이상하게 이걸 해줘야 variable 을 프로메테우스 테이블에서 읽어올 수 있음..)

### MySQL
```SQL
SHOW MASTER STATUS; # 현재 빈로그 파일명, 빈로그 위치, GTID 조회

SHOW BINARY LOGS; # 빈로그 파일 리스트 조회
```

### 참고 사항
컨테이너가 6개 실행되고 특히 connect1, connect2 가 메모리를 많이 사용한다.
기본 도커 메모리 설정이 2GB 인데, 전부 실행하는데 메모리가 부족하여 connect1 또는 connect2 가 Exited127 로 종료된다.
따라서 도커 메모리 크기를 늘리고 컴포즈를 실행하도록 한다. (넉넉하게 8GB 할당하여 사용)