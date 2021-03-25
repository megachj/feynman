# 내용

# 데이터 흐름

# 실행 방법
## 도커 컴포즈 실행
```sh
# 1. 도커 네트워크 설정
sh ./setup-network.sh

# 2. 도커 컴포즈 실행(zookeeper, kafka, mysql, connect1, connect2)
docker-compose up -d
```
