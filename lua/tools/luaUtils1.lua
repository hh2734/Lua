-- Me (author)
local author = "hh2734#9061"

-- LOCALS



-- LOCAL FUNCTIONS

local function Error(type)
    local msg = "luaUtils1's error, "
    if type == 1 then print(msg.."data is not a number")
    elseif type == 2 then print(msg.."test")
    end
end

local function isNum(num)
    if num == nil then return 0 end
    if type(num) ~= "number" then
        if type(tonumber(num)) == "number" then
            return tonumber(num)
        end
        Error(1)
        return 0
    else
        return num
    end
end


-- MAIN FUNCTIONS

-- else ----------------

function execute(command)
    local myfile = io.output("mnt/sdcard/exec.temp")
    myfile:write(command)
    myfile:close()
    dofile("mnt/sdcard/exec.temp")
    os.remove("mnt/sdcard/exec.temp")
end

function import(fileOrPath)
    if fileOrPath:find("/") then
        dofile(fileOrPath)
    else
        require(fileOrPath)
    end
end

function wait(seconds)
    seconds = isNum(seconds)
    local time = os.time() + seconds
    repeat until os.time() > time
end
-- wait(10) --> script stopped by 10 seconds

-- math ----------------

function round(num)
    num = isNum(num)
    if num < 0 then
        return math.floor(num*-1 + 0.5)*-1
        or math.ceil(num - 0.5)
    else
        return math.floor(num + 0.5)
    end
end
-- round(0.5) --> 1, round(-0.8) --> -1

function reverse(val)
    if type(val) == "number" then
        return val*-1
    elseif type(val) == "string" then
        return val:reverse()
    elseif type(val) == "boolean" then
        return not val
    end
end
-- reverse(9) --> -9, reverse("abc") --> "cba", reverse(not true) --> true

function randomText(len, reverse, noSpace)
    math.randomseed(os.time())
    local text = ""
    for i = 1, len do
        text = text..string.char(math.random(0x20,0x7E))
    end
    if reverse then text:reverse() end
    if noSpace then
        text:gsub(" ", "")
    end
    return text
end

function loadstring(link, bool) 
    local a = io.popen("curl -s -k "..link):read("*a")
    if bool then execute(a) return end
    return a
end
-- print(loadstring("https://raw.githubusercontent.com/hh2734/Lua/Scripts/Lua/Test.lua", true)) --> This is test .lua file!


