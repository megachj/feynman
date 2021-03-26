# 실행 방법
## 도커 컴포즈 실행
```sh
# 1. 도커 네트워크 설정
sh ./setup-network.sh

# 2. 도커 컴포즈 실행(zookeeper, kafka, mysql, connect1, connect2)
docker-compose up -d
```

## 참고 사항
컨테이너가 6개 실행되고 특히 connect1, connect2 가 메모리를 많이 사용한다.
기본 도커 메모리 설정이 2GB 인데, 전부 실행하는데 메모리가 부족하여 connect1 또는 connect2 가 Exited127 로 종료된다.
따라서 도커 메모리 크기를 늘리고 컴포즈를 실행하도록 한다. (넉넉하게 8GB 할당하여 사용)