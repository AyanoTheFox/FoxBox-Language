--[[
    fox languague created by devlops ayano and help of prof choco <3 on day 21th juny of 2023 to versions of lua 3.5.6 or bigger than
]]
parser = require 'parser'

local data = io.open('Test.fb')
    for l in data:lines() do
        parser:run(l)
    end
data:close()
