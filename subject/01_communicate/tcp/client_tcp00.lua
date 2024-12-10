local socket = require("socket")

local client = socket.connect("localhost", 4242)

if client then
    client:settimeout(10)

    client:send("Hello server!\n")

    local response, err = client:receive()
    if not err then
        print("Server : " .. response)
    else
        print("Err : " .. err)
    end

    client:close()
else
    print("Can not connect to server.")
end