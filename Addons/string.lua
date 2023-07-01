function string.split(str, split)
    local t = {}
    
    for substr in string.gmatch(str, '([^' .. (split or 's%') .. ']+)') do
        table.insert(t, substr)
    end
    
    return t
end

function string.between(str, between1, between2)
    local t = {}
    
    for substr in string.gmatch(str, (between1 or '%s') .. '(.+)' .. (between2 or '%s')) do
        table.insert(t, substr)
    end
    
    return t
end

function string.math(str)
    local func = assert(load("return " .. str))
    
    return tonumber(func())
end

return string.split, string.between, string.math