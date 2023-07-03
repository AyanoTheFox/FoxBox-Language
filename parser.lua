require 'Addons/string'
parser = {}

function parser:run(cmd)
    if not cmd:match('^%s*$') then
        local commentary = string.split(cmd, '?')
        local token = string.split(commentary[1], ';')
        
        for t = 1, #token do
            if token[t]:match('=') then
                local memb = string.split(token[t], '=')
                local param = string.split(memb[2], '%s')
                
                if param[1] == 'int:' then
                    if tonumber(param[2]) ~= math.floor(tonumber(param[2]))  then
                        error("expected int number got float")
                    elseif string.between(memb[2], '"', '"')[1] then
                        error("expected int number got string")
                    elseif param[2] == 'false' or param[2] == 'true' then
                        error("expected int number got bool")
                    elseif not param[2] then
                        error("expected int number got nil")
                    else
                        local expression = {}
                        
                        for p = 2, #param do
                            table.insert(expression, param[p])
                        end
                        
                        if string.math(table.concat(expression)) == math.floor(string.math(table.concat(expression))) then
                            _G[memb[1]:gsub('%s', '')] = string.math(table.concat(expression))
                            print(_G[memb[1]:gsub('%s', '')])
                        else
                            error("the expression result not is a int number")
                        end
                    end
                elseif param[1] == 'float:' then
                    if string.between(memb[2], '"', '"')[1] then
                        error("expected number got string")
                    elseif param[2] == 'false' or param[2] == 'true' then
                        error("expected number got bool")
                    elseif not tonumber(param[2]) then
                        error("expected number got nil")
                    else
                        _G[memb[1]:gsub('%s', '')] = string.math(param[2])
                        print(_G[memb[1]:gsub('%s', '')])
                    end
                elseif param[1] == 'unsigned' then
                    if param[2] == 'int:' or param[2] == 'float:' then
                        if param[3] == (string.between(memb[2], '"', '"') or string.between(memb[2], "'", "'") )then
                            if param[2] == 'int:' then
                                error("expected unsigned int got string")
                            else
                                error("expected unsigned int got string")
                            end
                        elseif param[3] == 'false' or param[3] == 'true' then
                            if param[2] == 'int:' then
                                error("expected unsigned int got bool")
                            else
                                error("expected unsigned number got bool")
                            end
                        elseif not param[3] then
                            if param[2] == 'int:' then
                                error("expected unsigned int got nil")
                            else
                                error("expected unsigned number got nil")
                            end
                        elseif tonumber(param[3]) ~= math.floor(tonumber(param[3]))  then
                            if param[2] == 'int:' then
                                error("expected unsigned int got float")
                            else
                                error("expected unsigned number got float")
                            end
                        elseif tonumber(param[3]) ~= math.abs(tonumber(param[3])) then
                            if param[2] == 'int:' then
                                error("expected unsigned int got a negative number")
                            else
                                error("expected unsigned number got a negative number")
                            end
                        else
                            local expression = {}
                        
                            for p = 3, #param do
                                table.insert(expression, param[p])
                            end
                        
                            if string.math(table.concat(expression)) ~= -math.abs(string.math(table.concat(expression))) or string.math(table.concat(expression)) ~= math.floor(string.math(table.concat(expression))) then
                                _G[memb[1]:gsub('%s', '')] = string.math(table.concat(expression))
                                print(_G[memb[1]:gsub('%s', '')])
                            elseif string.math(table.concat(expression)) ~= -math.abs(string.math(table.concat(expression))) then
                                error("the expression result in a  not positive number")
                            else
                                error("the expression result in a not int number")
                            end
                        end
                    else
                        error("unexpected unsigned type")
                    end
                elseif param[1] == 'signed' then
                    if param[2] == 'int:' or param[2] == 'float:' then
                        if param[3] == (string.between(memb[2], '"', '"') or string.between(memb[2], "'", "'") )then
                            if param[2] == 'int:' then
                                error("expected signed int got string")
                            else
                                error("expected signed int got string")
                            end
                        elseif param[3] == 'false' or param[3] == 'true' then
                            if param[2] == 'int:' then
                                error("expected signed int got bool")
                            else
                                error("expected signed number got bool")
                            end
                        elseif not param[3] then
                            if param[2] == 'int:' then
                                error("expected signed int got nil")
                            else
                                error("expected signed number got nil")
                            end
                        elseif tonumber(param[3]) ~= math.floor(tonumber(param[3]))  then
                            if param[2] == 'int:' then
                                error("expected signed int got float")
                            else
                                error("expected signed number got float")
                            end
                        elseif tonumber(param[3]) ~= -math.abs(tonumber(param[3])) then
                            if param[2] == 'int:' then
                                error("expected signed int got a positive number")
                            else
                                error("expected signed number got a positive number")
                            end
                        else
                            local expression = {}
                        
                            for p = 3, #param do
                                table.insert(expression, param[p])
                            end
                        
                            if string.math(table.concat(expression)) ~= math.abs(string.math(table.concat(expression))) then
                                _G[memb[1]:gsub('%s', '')] = string.math(table.concat(expression))
                                print(_G[memb[1]:gsub('%s', '')])
                            elseif string.math(table.concat(expression)) ~= math.abs(string.math(table.concat(expression))) then
                                error("the expression result not is a negative number")
                            end
                        end
                    else
                        error("unexpected signed type")
                    end
                elseif param[1] == 'str:' then
                    local str
                    
                    if string.between(memb[2], "'", "'")[1]:match('"(.+)"') then
                        str = string.between(memb[2], "'", "'")[1]
                    elseif string.between(memb[2], '"', '"')[1]:match("'(.+)'") then
                        str = string.between(memb[2], '"', '"')[1]
                    else
                        str = string.between(memb[2], '"', '"')[1] or string.between(memb[2], "'", "'")[1]
                    end
                    
                    
                    if not param[2] then
                        error("expected string got nil")
                    elseif tonumber(param[2]) then
                        error("expected string got number")
                    elseif param[2] == 'false' or param[2] == 'true' then
                        error("expected string got bool")
                    else
                        _G[memb[1]:gsub('%s', '')] = str
                        print(_G[memb[1]:gsub('%s', '')])
                    end
                elseif param[1] == 'char:' then
                    local char = string.between(memb[2], '"', '"')[1] or string.between(memb[2], "'", "'")[1]
                    
                    if char:len() > 1 then
                        error("expected char got string")
                    elseif tonumber(param[2]) then
                        error("expcted char got number")
                    elseif param[2] == 'false' or param[2] == 'true' then
                        error("expected char got bool")
                    elseif char:len() == 1 then
                        _G[memb[1]:gsub('%s', '')] = char
                        print(_G[memb[1]:gsub('%s', '')])
                    end
                elseif param[1] == 'bool:' then
                    if string.between(memb[2], '"', '"')[1] then
                        error("expected bool got string")
                    elseif not param[2] then
                        error("expected bool got nil")
                    elseif param[2] == 'false' or tonumber(param[2]) == 0 then
                        _G[memb[1]:gsub('%s', '')] = false
                        print(_G[memb[1]:gsub('%s', '')])
                    elseif param[2] == 'true' or tonumber(param[2]) == 1 then
                        _G[memb[1]:gsub('%s', '')] = true
                        print(_G[memb[1]:gsub('%s', '')])
                    end
                else
                    local expression = {}
                    
                    for p = 1, #param do
                        table.insert(expression, _G[param[p]:gsub('%s', '')] or param[p])
                    end
                    
                    _G[memb[1]:gsub('%s', '')] = string.math(table.concat(expression))
                    print(_G[memb[1]:gsub('%s', '')])
                end
            end
        end
    end
end

return parser
