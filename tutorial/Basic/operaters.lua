-- # Arithmetic Operators

a = 21
b = 10
result = a + b
print("a + b = ", result )

result = a - b
print("a - b = ", result )

result = a * b
print("a * b = ", result )

result = a / b
print("a / b = ", result )

a = 10
b = 20
c = 25
result = b % a
print("b % a = ", result )

result = c % a
print("b % a = ", result )


-- # Logical Operators
print()
local a = true 
local b = false

print("a and b = ", (a and b))
print("a or b = ", (a or b))
print("not(a or b) = ", not(a or b))


-- # Miscellaneous operators
print()
a = "Hello"
b = "World"

print("Concatenation of string a with b is ", a..b)


print()
b = "World"
print("Length of b is ",#b )
print("Length of Test is ",#"Test" )