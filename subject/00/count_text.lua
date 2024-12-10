
local function is_printable_character(char)
    local ascii_value = string.byte(char)
    if (ascii_value and ascii_value > 32 and ascii_value < 127) then
        return true
    else
        -- print("not printable char : " .. char .. ascii_value)
        return false
    end
end

local function is_alphabet(char)
    local ascii_value = string.byte(char)
    if ((ascii_value and ascii_value >= 65 and ascii_value <= 90) or
        (ascii_value and ascii_value >= 97 and ascii_value <= 122)) then
        return true
    else
        -- print("not printable char : " .. char .. ascii_value)
        return false
    end
end

--[[
    return 될 변수가 local로 선언되어 있으면 결과와 내부동작은 어떻게 되는가?
--]]
local function init_each_character_count_table()
    local each_character_count_table = {}
    -- 알파벳 대, 소문자 순서대로 초기화 
    for ascii_value = 33, 126, 1 do 
        local char = string.char(ascii_value)
        if (is_alphabet(char)) then
            each_character_count_table[char] = 0
        end
    end
    return each_character_count_table
end

local function validate_argument() 
    local file_path = arg[1]

    -- 입력 파일이 있어야한다. 
    if file_path == nil then
        print("인자로 텍스트 파일을 입력해주세요.")
        return false
    else
        return true
    end
end
-- local function main() -- local을 씀으로써 다른 파일에서 못 쓰게 할 수 있음
function main()
    -- # 0. 인자 확인
    if (validate_argument() == false) then
        return 1
    end
    
    -- # 1. 파일 읽기
    -- # 2. 줄 수 세기
    -- # 3. 캐릭터 세기
    local line_count = 0
    --[[
        - ascii순서대로 초기화 할 것인가?
        - 아니라면 알파벳 순서대로 초기화 할 것인가?
        - 알파벳 대문자, 소문자 순서대로 할 것인가?
        1. 알파벳 대문자, 소문자 순서대로 초기화 한다.
    --]]
    -- init_each_character_count_table() return이 local variable인데 메모리 상의 문제는 없는가? 
    -- segfault라거나 접근하면 안되는 메모리에 접근했다거니 등등
    local each_character_count_table = init_each_character_count_table()

    -- 키-값 쌍 반복
    -- for k, v in pairs(each_character_count_table) do
    --     print(k, v)
    -- end

    local file = io.open(arg[1], "r")
    if file then
        -- local text = file:read("*all")
        local line = file:read("*line")
        while line do
            line_count = line_count + 1
            -- io.write(line)
            print(line)
            for idx = 1, #line do
                local char = line:sub(idx, idx)

                -- 출력 가능한 문자라면 문자를 센다
                if is_alphabet(char) then
                    each_character_count_table[char] = each_character_count_table[char] + 1
                    -- print("char : " .. char)
                else
                    -- TODO: remove
                    -- print("이 문자는 출력이 불가한 문자입니다.")
                end
            end
            line = file:read("*line")
        end
        file.close()
    else
        -- print(arg[1] .. " 파일이 없습니다.")
        io.write(arg[1], " 파일이 없습니다.\n")
        return 1
    end

    -- # 4. 결과 출력
    print("filename:\t" .. arg[0])
    print("execute:\t" .. arg[-1] .. arg[0] .. arg[1] )
    print("output:\t")
    print("lines:\t" .. line_count)
    print("characters:\t")
    -- 키-값 쌍 반복
    -- table.sort(each_character_count_table)
    -- for k, v in pairs(each_character_count_table) do
    -- for i, v in ipairs(each_character_count_table) do
    -- table.sort(each_character_count_table)
    -- for k, v in ipairs(each_character_count_table) do
    --     -- print("\t", i, v)
    --     print("\t" .. k .. ":\t" .. v)
    -- end

    --[[
        -- 키를 정렬한 후 순회
        local sorted_keys = {}
        for k in pairs(each_character_count_table) do
            table.insert(sorted_keys, k)
        end

        -- 키를 오름차순으로 정렬
        table.sort(sorted_keys)
    --]]
    local sorted_keys = {}
    for k in pairs(each_character_count_table) do
        table.insert(sorted_keys, k)
    end

    -- 키를 오름차순으로 정렬
    table.sort(sorted_keys)

    -- 정렬된 키에 따라 값 순회
    -- for _, k in ipairs(sorted_keys) do
    --     print("\t" .. k..":\t" .. each_character_count_table[k])
    -- end
end

-- 직접 호출한 경우에만 동작하게 하는 것이 나은가?
-- 인자로 텍스트 파일을 받아야 하므로 의미가 있을 것인가? 추가 확인 필요
if arg and arg[0] == "count_text.lua" then
    main()
end