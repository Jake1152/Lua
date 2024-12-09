print(type("What is my type")) --> string
t = 10

print(type(5.8*t)) --> number
print(type(true)) --> boolean
print(type(print)) --> function
print(type(nil)) -->nill
print(type(type(ABC))) -->string


function max(num1, num2)
    if (num1 > num2) then
        result = num1;
    else
        result = num2;
    end

    return result;
end

print("\n")
print("=============================================")
print("\n")


-- get the type of a function
print("The type of the function ", type(max))

-- get the type of result of function
print("The type of the function ",type(max(3,4)))

-- get the result of function
print("The Max Value: ",max(3,4))