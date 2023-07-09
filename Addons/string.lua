function string.split(str, split)
    local t = {}
    
    for substr in str:gmatch('([^' .. (split or 's%') .. ']+)') do
        table.insert(t, substr)
    end
    
    return t
end

function string.between(str, between1, between2)
    local t = {}
    
    for substr in str:gmatch((between1 or '%s') .. '(.+)' .. (between2 or '%s')) do
        table.insert(t, substr)
    end
    
    return t
end

function string.isOnly(str, is)
    if str:match('^' .. is .. '*$') then
        return true
    end
end

function string.math(str)
    local func = assert(load("return " .. str))
    
    return tonumber(func())
end

return string.split, string.between, string.math, string.isOnly
