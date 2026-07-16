

-- Returns index of a given value from a list, or return nil if no matches found
function indexOf(array, value)
    for i, v in ipairs(array) do if v == value then return i end end
    return nil
end

-- Rounds a decimal number to closest number of certain decimal places, defaulting to zero
function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

-- yahimouse helper function reference
function findOutIfThisNumberIsEvenInTheMostInefficientWayPossible(num)
    local even = true
    local count = 0
    if num < 0 then
        local double = num + num
        num = num - double
    end
    local integercomponent = 0
    local number = num
    while true do
        integercomponent = integercomponent + 1
        number = number - 1
        if number < 1 then
            break
        end
    end
    local checkfordecimal = 0
    checkfordecimal = num - integercomponent
    if checkfordecimal == 0 then
        -- no decimal :)
    else
        return false
    end
    while true do
        count = count + 1
        if count == num then
            break
        else
            if even == true then
                even = false
            else
                even = true
            end
        end
    end
    if even == true then
        return true
    else
        return false
    end

end