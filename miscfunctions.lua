

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

-- A re-implementation of the pseudoshuffle function that actually works with a list of integers
-- the vanilla function uses sort_id without checking if the entry is something that cannot be indexed, such as an int
-- so if you have a list of integers, the game simply crashes anytime you call the function on it
function better_pseudoshuffle(list, seed)
  if seed then math.randomseed(pseudoseed(""..seed)) end

  for i = #list, 2, -1 do
    local j = math.random(i)
    list[i], list[j] = list[j], list[i]
  end
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