-- #00 The Infinite Loop
-- define an infinite loop
-- while (true)
-- do
--     print("This loop will run forever.")
-- end


-- #01 while basic
print()

local a = 10

while (a < 20)
do
    print("value of a : ", a)
    a = a + 1
end

-- #01 with array
print()
local numbers = {10, 20, 30, 40 ,50}
index = 1

while (index <= 5)
do
    print("value of item : ", numbers[index])
    index = index + 1
end


-- #02 for loop
-- for init, max/min value, increment
-- do
--     statement(s)
-- end
print()
for i = 10, 19, 1
do
    print(i)
end


print("\ndecrement")
for j = 10, 5, -1
do
    print("j : ", j)
end

print("\nwith arrays")
local numbers = {10, 20, 30, 40, 50}
-- # is arrays length 반복되는 어떤 것이라면 다 길이를 잴 수 있는가?
for i = 1, #numbers, 1
do
    print(numbers[i])
end

num, i = 1, 1

local write = io.write


-- outer for loop
-- 폐구간 열림, 닫힘
-- <= 과 같음
print("\nouter for loop")
for num = 1, 10, 1
do
    write("Table of ", num, " is : ")
    for i = 1, 10, 1
    do
        write(num * i, " ")
    end
    -- print a new line
    print()
end

-- #03 repeat
--[[repeat
    statment(s)
    until( condition )
--]]

print("\nrepeat")
--[[
ㅁㅁ하지 않는 동안 반복
--]]
i = 10
repeat
    print("value of i: ", i)
    i = i + 1
until i > 20


local numbers = {10, 20, 30, 40, 50}
local i = 1
repeat
    print("numbers[", i, "] : ", numbers[i])
    i = i + 1
until i > 5


-- #04 nested loop
--[[
for init, max/min value, increment
do
    for init, max/min value, increment
    do
        statement(s)
    end
    statement(s)
end
--]]

--[[
TO BE output
Jan	Sun
Jan	Mon
Jan	Tue
Feb	Sun
Feb	Mon
Feb	Tue
Mar	Sun
Mar	Mon
Mar	Tue
--]]

print("\n#05 nested loop")
months = {"Jan", "Feb", "Mar"}
days = {"Sun", "Mon", "Tue"}

print("## nested for loop")
for i = 1, 3, 1
do
    for j = 1, 3, 1
    do
        print(months[i], days[j])
        j = j + 1
    end
    i = i + 1
end

print("## nested while loop")
print("### nested while loop 00")
local i = 1
while i <= 3
do
    local j = 1
    while j <= 3
    do
        print(months[i], days[j])
        j = j + 1
    end
    i = i + 1
end
print("### nested while loop 01")
i = 2
while i < 25
do
   j = 2
   while j <= (i/j)
   do
      if(i%j == 0)
      then
         break
      end
      j = j + 1
   end
   if(j > (i/j))
   then
      print(i, " is prime")
   end
   i = i + 1
end

--[[
repeat
   statement(s)
   repeat
      statement(s)
   until( condition )
until( condition )
--]]

--[[
# TO BE
2	 is prime
3	 is prime
5	 is prime
7	 is prime
11	 is prime
13	 is prime
17	 is prime
19	 is prime
23	 is prime
--]]
print("\n\nrepeat until version")

-- 1과 자신만으로만 나누어지는 수
function is_prime(num)
    if (num == 1) then
        return false
    elseif (num == 2) then
        return true
    end

    divisor = 2
    repeat
        if (num % divisor == 0) then
            return false
        end
        divisor = divisor + 1
    until divisor >= num
    -- if (num % 2 == 0) then
    --     return false
    -- end
    return true
end

local num = 2
repeat
    -- print("is_prime(", num, ") : ", is_prime(num))
    if (is_prime(num)) then
        print(num, "is prime.")
    end
    num = num + 1
    -- print("num is ", num)
until num > 25


--[[

i = 2
repeat 
do
   j = 2
   repeat 
   do
      if(i%j == 0)
      then
         break
      end
      j = j + 1
   end
   until j > (i/j)
   if(j > (i/j))
   then
      print(i, " is prime")
   end
   i = i + 1
end
until i > 25

--]]



print("\n#06 break statement")
--[ local variable definition --]
a = 10

--[ while loop execution --]
while( a < 20 )
do
   print("value of a:", a)
   a=a+1
	
   if( a == 15)
   then
      --[ terminate the loop using break statement --]
      break
   end
	
end


numbers = {10, 20, 30, 40, 50}
print()
for i = 1, #numbers
do
   if (numbers[i] == 30)
   then
      break;
   end
   print("Value of Item:",numbers[i])
end

print()
a = 10
while true
do
   print("value of a:", a)
   a=a+1

   if( a == 15)
   then
      break
   end
end