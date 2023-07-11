function toboolean(str)
    if str:lower() == 'true' or tonumber(str) == 1 then
        return true
    elseif str:lower() == 'false' or tonumber(str) == 0 then
        return false
    else
        error("invalid value to pass to boolean")
    end
end

return toboolean