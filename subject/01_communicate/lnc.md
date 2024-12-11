# t02_net_util
UDP 송수신 유틸리티
netcat 과 유사한 기능. [NETCAT](https://ko.wikipedia.org/wiki/Netcat)

### usage
프로그램명:  lnc   (lua version netcat)

##### UDP 12006 포트로 수신 대기
```
    lnc -l -u 12006
```
- 수신받은 데이터는 stdout 에 출력
- 프로그램 종료시 아래와 같은 수치를 표기
    - 수신받은 총 건수 (received event count)
    - 수신받은 총 바이트수 (received bytes)
- 입력 인자로 IP 추가


##### UDP 12006 포트로 송신
```
    lnc -u 12006

    ddd
    aaaaa
```
'ddd', 'aaaaa' 등의 stdin 값을 UDP 12006 포트로 송신.

# 의문점
1. ip는 우선 localhost인 것을 전제로 하게 되는지
2. ip도 추후에 설정하게 되는지
=> lua버젼의 nc이므로 추가될 것이라 생각


# 문제이해
- udp 통신만 되는 nc와 같은 프로그램을 만든다.
- lnc -l -u [PORT] 같은 입력만 가능하다
  - 첫번째 인자로는 -l 또는 -u만 올 수 있다.
  - -u 다음 인자로는 숫자만 올 수 있다.
  - -u 인자와 port 번호는 항상 있어야만 한다.
  - 이미 같은 port로 서버가 띄워져 있는지 확인해야 한다.

- -l 이면 입력된 포트로 서버를 띄운다.
  - 이미 같은 포트로 서버가 띄워져 있는지 확인한다.
  - 같은 포트로 띄워져 있는 서버가 없다면 서버를 실행한다.
  - client로부터 입력이 들어올 때까지 기달린다.
- -u와 port만 들어온 경우,
   port가 적힌 곳으로 메시지를 전송한다.
   실패하면 에러 처리


## Ref
```Lua
-- change here to the host an port you want to contact
local host, port = "localhost", 13
-- load namespace
local socket = require("socket")
-- convert host name to ip address
local ip = assert(socket.dns.toip(host))
-- create a new UDP object
local udp = assert(socket.udp())
-- contact daytime host
assert(udp:sendto("anything", ip, port))
-- retrieve the answer and print results
io.write(assert(udp:receive()))
```