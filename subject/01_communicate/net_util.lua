local socket = require("socket")
local host = "localhost"

-- 인자 간이 확인 버젼
local validate_arugment = function()
    if (not arg or not arg[1] or not arg[2]) then
        return false
    end
    return true
end

local server = function(port)
    local udp_server = socket.udp()

    -- local ip = assert(udp_server.dns.toip(host))
    -- local udp = assert(udp_server.udp())

    local ip = assert(socket.dns.toip(host))
    assert(udp_server:settimeout(0))  -- Non-blocking mode
    assert(udp_server:setsockname(ip, port))  -- 지정된 포트에서 서버 시작
    
    -- print("UDP server start on " .. port)
    print("UDP server started on " .. host .. ":" .. port)

    while true do
        local data, ip, port = udp_server:receivefrom()
        if data then
            io.write(data)
            assert(udp_server:sendto(data, ip, port))
        end
    end
end

local client = function(port)
    
end


local main = function()
    -- # 0. validate arguemnt 
    if (validate_arugment() == false) then 
        return 1
    end

    -- # 1. server, client 분기
    -- if (server) then
    -- else
    -- end
    if (arg[1] == "-l") then
        print("listen option!")
        local port = arg[3]
        -- server
        server(port)
    else
        local port = arg[2]
        client(port)
    end

end

main()