local socket = require("socket")

local udp = socket.udp()

-- udp:sendto("Hello UDP server", "localhost", 4242)
udp:sendto("안녕하세요 UDP 서버!", "localhost", 4242)
-- udp:sendto("안녕하세요 UDP 서버!", "127.0.0.1", 4242)
udp:settimeout(2)

local response, err = udp:receive()

if response then
    print("Server : " .. response)
else
    print("Err : " .. err)
end

udp:close()