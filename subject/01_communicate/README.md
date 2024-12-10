# t02_net_util


UDP 송수신 유틸리티

netcat 과 유사한 기능. [NETCAT](https://ko.wikipedia.org/wiki/Netcat)


### usage

프로그램명:  lnc   (lua version netcat)


##### UDP 12006 포트로 수신 대기

```
    lnc -l -u 12006
```

수신받은 데이터는 stdout 에 출력


##### UDP 12006 포트로 송신

```
    lnc -u 12006

    ddd
    aaaaa

```
'ddd', 'aaaaa' 등의 stdin 값을 UDP 12006 포트로 송신.




