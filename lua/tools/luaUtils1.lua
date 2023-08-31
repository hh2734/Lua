-- Me (author)

local author = "hh2734#9061" -- ☆☆☆☆☆

-- LOCALS

local utils = {}


-- LOCAL FUNCTIONS

local function Error(num, ...) -- ☆☆
    local msg = "luaUtils1's error, "
    local args = {...}
    if num == 1 then print(msg.."incorrect type: "..args[1])
    end
end

local function isNum(num) -- ☆☆☆
    if num == nil then Error(1,"nil") return 0 end
    if tonumber(num) ~= "number" then
        Error(1, type(num))
        return 0
    else
        return num
    end
end


-- MAIN FUNCTIONS

function utils.execute(code)
    local func, err = load(code)
    if not func then
        return nil, err 
    end 
    local success, returnValue = pcall(func) 
    if not success then
        return nil, returnValue
    end
    return returnValue, true
end
-- safe execute function

function utils.output(command) -- ☆☆☆
    return io.popen(command):read("*a")
end

function utils.wait(seconds) -- ☆☆☆☆
    seconds = isNum(seconds)
    if seconds <= 0 then return end
    local time = os.time() + seconds
    repeat until os.time() == time
end
-- wait(10) --> script stopped by 10 seconds

function utils.round(num) -- ☆☆☆☆
    num = isNum(num)
    if num < 0 then
        return math.floor(num*-1 + 0.5)*-1
        or math.ceil(num - 0.5)
    else
        return math.floor(num + 0.5)
    end
end
-- round(0.5) --> 1, round(-0.8) --> -1

function utils.reverse(val) -- ☆☆☆☆
    if type(val) == "number" then
        return val*-1
    elseif type(val) == "string" then
        return val:reverse()
    elseif type(val) == "boolean" then
        return not val
    else
        Error(1,type(val))
        return 0
    end
end
-- reverse(9) --> -9, reverse("abc") --> "cba", reverse(not true) --> true

function utils.randomText(len, noSpace, noSymbols, noNumbers, noLetters, reverse) -- ☆☆☆☆
    math.randomseed(os.time())
    local text = ""
    for i = 1, len do
        text = text..string.char(math.random(0x20,0x7E))
    end
    if reverse   then text = text:reverse()      end
    if noSpace   then text = text:gsub("%s","")  end
    if noSymbols then text = text:gsub("%p","")  end
    if noNumbers then text = text:gsub("%d","")  end
    if noLetters then text = text:gsub("%a","")  end
    return text
end

return utils
