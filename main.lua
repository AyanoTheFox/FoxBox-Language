--[[
    foxbox languague created by devlops ayano and help of prof choco <3 on day 21th juny of 2023 to versions of lua 3.5.6 or bigger than
]]
parser = require 'parser'
foxbox = {}

function foxbox.decode(file)
    if not file then
        error("userdata expected got nil")
    end
    
    local t, data = {}, io.open(file)
    for l in data:lines() do
        t = parser:run(l)
    end
    data:close()
    return t
end

return foxbox
