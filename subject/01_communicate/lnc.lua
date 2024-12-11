local socket = require("socket")
local host = "localhost"
local posix_signal = require("posix.signal")

local total_message_count = 0
local total_message_size = 0

-- ============================= argument parsing =============================
-- 인자 간이 확인 버젼
--[[ #TODO:
- 인자 개수가 잘 맞는가?
  - 인자 2개 이상
- 인자 형식이 잘 맞는지
  - -l -u [PORT]
  - -u [PORT]
- 인자 유형별로 형식이 잘 맞는지
  - 서비스 다음에 -l이 나오거나 -u가 나와야 한다.
  - 서버일 때, -l
    - -l 다음에 -u가 잘 나오는지
  - UDP 옵션
    - -u 다음에는 port가 나와야함
  - PORT 형식 체크
    - 숫자 65535

처리 방법
1. if 문
2. ENUM같은 것이 있는지 확인, 컴파일러 방식 
   유한오토마타
--]]
local is_udp_type = function(protocol_type)
    if (protocol_type and protocol_type == "-u") then
        print("udp protocol type")
        return true
    end
    return false
end

local is_port = function(port)
    -- tonumber() 결과로 NAN 같은 값이 발생할 수 있는가?
    port = tonumber(port)

    -- well known port(0~1023)는 제외하는 것이 나을지 고려
    if (port and (port >= 0 and port < 2^16)) then
        print("tonumber(port) result : " .. port .. " in is_port()")
        return true
    end
    return false
end

--[[
- -l -u [PORT]
- -u [PORT]
- 인자 유형별로 형식이 잘 맞는지
- 서비스 다음에 -l이 나오거나 -u가 나와야 한다.
- 서버일 때, -l
    - -l 다음에 -u가 잘 나오는지
- UDP 옵션
    - -u 다음에는 port가 나와야함
- PORT 형식 체크
    - 숫자 65535
--]]
local validate_arugment = function()
    -- 0. 인자 개수 확인
    if (not arg or not arg[1] or not arg[2]) then
        return false
    end

    -- #TODO: 왜 통과가 안되는지 확인 필요
    -- 1. 인자 형식이 잘 맞는지
    -- if (arg[1] == "-l" and (is_udp_type(arg[2]) and is_port(arg[3])) == false) then -- server
    --     return false
    -- elseif ((is_udp_type(arg[1]) and is_port(arg[2])) == false) then -- client
    --     return false
    -- else
    --     return false
    -- end
    return true
end

-- ============================= signal =============================
--[[
 종료를 의미하는 다른 시그널을 알아야할 필요가 있을까?
 서버를 띄웠을 때는 계속 데이터를 받게 될 것이므로 
--]]
local signal_handler = function(signum)
    print()
    print("수신받은 총 건수 (received event count): " .. total_message_count)
    print("수신받은 총 바이트수 (received bytes): " .. total_message_size) 
    os.exit(128 + signum)
end

-- ============================= server, client =============================

local server = function(port)
    posix_signal.signal(posix_signal.SIGINT, signal_handler)

    local udp_server = socket.udp()

    local ip = assert(socket.dns.toip(host))
    assert(udp_server:settimeout(0))  -- Non-blocking mode
    assert(udp_server:setsockname(ip, port)) 

    print("UDP server started on " .. host .. ":" .. port)
    while true do
        local data, ip, port = udp_server:receivefrom()
        if data then
            total_message_count = total_message_count + 1
            -- TODO: 개행 문자 추가로 1바이트씩 추가로 읽히게 됨, 계산에서는 제외할지 고려 필요
            total_message_size = total_message_size + #data
            io.write(data)
        end
    end
    --[[
        if pcall(function ()
                -- 지정된 포트에서 서버 시작
                if (udp_server:setsockname(ip, port) == false) then
                    error()
                end
                print(a[i])
            -- #TODO: error문구 확인 이후 정제하여 해당 에러 문구로 출력 필요
            -- print("lnc: Address already in use")
        end) then -- no error
        else -- error
        end
    --]]
end

local client = function(port)
    local udp_client = socket.udp()
    local ip = assert(socket.dns.toip(host))
    
    --[[
        - assert를 하는 게 맞는가?
          예외를 별도로 처리 하는 것이 맞는가?
        - 메시지 끝에 개행을 넣는 방식 vs 메시지 길이 정보를 패킷 형식으로 포함 하는 방식
    --]]
    local data = ""
    while (true) do
        data = io.read() .. "\n"
        assert(udp_client:sendto(data, ip, port))
    end
end

local main = function()
    -- # 0. validate arguemnt 
    if (validate_arugment() == false) then 
        print("잘못된 인자를 입력 해주셨습니다.\n# 실행 형식\n\t서버: lua lnc.lua -l -u [PORT]\n\t클라이언트: lua lnc.lua -u [PORT]")
        return 1
    end
    -- # 1. server, client 분기
    if (arg[1] == "-l") then
        local port = arg[3]
        server(port)
    elseif (arg[1] == "-u") then
        local port = arg[2]
        client(port)
    -- else -- #TODO: validate_arugment() 수정 이후 삭제 필요, 임시 분기문
        -- print("잘못된 인자를 입력 해주셨습니다.\n# 실행 형식\n\t서버: lua lnc.lua -l -u [PORT]\n\t클라이언트: lua lnc.lua -u [PORT]")
    end
end

main()