require 'Addons/string'
require 'Addons/toboolean'
foxbox = require 'foxbox'
vars = foxbox.decode('Test.fb')
a = 1
print(debug.getlocal(a, 1))
function getTableContent(tbl, indent)
    if not indent then 
        indent = 0 
    end
    local toprint = string.rep(" ", indent) .. "{\r\n"
    indent = indent + 1 
    for k, v in pairs(tbl) do
        toprint = toprint .. string.rep(" ", indent)
        if (type(k) == "number") then
            toprint = toprint .. "[" .. k .. "] = "
        elseif (type(k) == "string") then
            toprint = toprint  .. k ..  "= "   
        end
        if (type(v) == "number") then
            toprint = toprint .. v .. ",\r\n"
        elseif (type(v) == "string") then
            toprint = toprint .. "\"" .. v .. "\",\r\n"
        elseif (type(v) == "table") then
            toprint = toprint .. getTableContent(v, indent + 2) .. ",\r\n"
        else
            toprint = toprint .. "\"" .. tostring(v) .. "\",\r\n"
        end
    end
    toprint = toprint .. string.rep(" ", indent-2) .. "}"
    return toprint
end

print(getTableContent(vars))