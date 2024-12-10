local moses = require("moses")

local is_alphabet = function(char)
    local ascii_value = string.byte(char)
    if ((ascii_value and ascii_value >= 65 and ascii_value <= 90) or
        (ascii_value and ascii_value >= 97 and ascii_value <= 122)) then
        return true
    else
        return false
    end
end

local read_file_content = function(file_name)
    local file = io.open(file_name, "r")
    
    if not file then return nil end
    
    local content = file:read("*all")

    file:close()
    return content
end

local validate_argument= function()
    local file_path = nil
    
    if arg and arg[1] then
        file_path = arg[1]
    end

    -- 입력 파일이 있어야한다. 
    if file_path == nil then
        print("인자로 텍스트 파일을 입력해주세요.")
        return false
    else
        return true
    end
end

local split = function(content, delimiter)
    local result = {}
    for part in string.gmatch(content, "([^" .. delimiter .. "]+)") do
        table.insert(result, part)
    end
    return result
end

-- local function main() -- local을 씀으로써 다른 파일에서 못 쓰게 할 수 있음
main = function()
    -- # 0. 인자 확인
    if (validate_argument() == false) then
        return 1
    end
    
    -- # 1. 파일 읽기
    local input_file = arg[1]
    local content = read_file_content(input_file)
    -- # 2. 줄 수 세기
    local lines = split(content, "\n")
    local line_count = #lines
    -- # 3. 캐릭터 세기
    local each_character_count_table = {}
    moses.map(lines, function(line)
        for idx = 1, #line do
            local char = line:sub(idx, idx)
            if is_alphabet(char) then
                if each_character_count_table[char] == nil then 
                    each_character_count_table[char] = 0
                end
                each_character_count_table[char] = each_character_count_table[char] + 1
            end
        end
        return each_character_count_table
    end)

    -- # 4. 결과 출력
    print("filename:\t" .. arg[0])
    print("execute:\t" .. arg[-1] .. arg[0] .. arg[1] )
    print("output:\t")
    print("lines:\t" .. line_count)
    print("characters:\t")
    local sorted_keys = {}
    for k in pairs(each_character_count_table) do
        table.insert(sorted_keys, k)
    end
    -- 키를 오름차순으로 정렬
    table.sort(sorted_keys)
    -- 정렬된 키에 따라 값 순회
    for _, k in ipairs(sorted_keys) do
        print("\t" .. k..":\t" .. each_character_count_table[k])
    end
end

main()
