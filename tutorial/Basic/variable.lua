--[[

Table fields − This is a special type of variable that can hold anything except nil including functions.
--]]


local i, j
local i 
local a, c


local d, g = 5, 10 

d, f = 5, 10; -- global variable

d , f = 10 --- global variable and declartion


-- Variable definition:
local a, b

-- Initialization
a = 10
b = 30

print("value of a:", a)

print("value of b:", b)

-- Swapping of variables
b, a = a, b

print("value of a:", a)

print("value of b:", b)

f = 70.0/3.0
print("value of f", f)