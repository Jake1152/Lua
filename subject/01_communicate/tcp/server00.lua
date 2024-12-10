local socket = require("socket")


local server = socket.bind("localhost", 4242)
server:settimeout(0) -- async version

print("서버 시작. 클라이언트의 접속을 기달림")

while true do
    local client = server:accept()

    if client then
        client:settimeout(10)

        local line, err = client:receive()
        if not err then 
            print("client : " .. line)
            client:send("msg received : " .. line .. "\n") -- ACK
        else
            print("Error : " .. err)
        end

        client:close() -- 클라이언트 연결 종료
    end
end