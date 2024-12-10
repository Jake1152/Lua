local socket = require("socket")

local udp = socket.udp()

-- 서버로 메시지 보내기
udp:sendto("안녕하세요 UDP 서버!", "127.0.0.1", 4242)

udp:settimeout(2)
local response, err = udp:receive()
if response then
    print("서버 응답: " .. response)
else
    print("응답 오류: " .. err)
end

udp:close()  -- 소켓 종료
