-- local check_argument = function()
--     return true
-- end

main = function()
    local socket = require("socket")
    
    local udp = socket.udp()
    
    udp:settimeout(0)

    udp:setsockname("localhost", 4242)

    print("UDP 서버 시작. 클라이언트 대기")

    while true do
        local data, ip, port = udp:receivefrom()
        if data then
            print("client : " .. data)
            udp:sendto("msg received : " .. data, ip, port)
        end
    end
end

main()