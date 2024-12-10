main = function()
    local socket = require("socket")

    -- UDP 소켓 생성
    local udp = socket.udp()
    udp:settimeout(0)  -- 비동기식 소켓

    -- 포트 바인딩
    udp:setsockname("127.0.0.1", 4242)

    print("UDP 서버가 시작되었습니다. 클라이언트를 기다립니다...")

    while true do
        -- 메시지 수신
        local data, ip, port = udp:receivefrom()
        if data then
            print("클라이언트로부터 받은 메시지: " .. data)
            udp:sendto("메시지 수신됨: " .. data, ip, port)
        end
    end
end

main()