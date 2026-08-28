-- Returns index of a given value from a list, or return nil if no matches found
function HangedMan.indexOf(array, value)
    if not array then return nil end
    if not value then return nil end
    for i, v in ipairs(array) do if v == value then return i end end
    return nil
end

-- Rounds a decimal number to closest number of certain decimal places, defaulting to zero
-- because for some reason lua is unable to provide this itself
function HangedMan.round(num, numDecimalPlaces)
    if not num then return nil end
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

-- A re-implementation of the pseudoshuffle function that actually works with a list of integers
-- the vanilla function uses sort_id without checking if the entry is something that cannot be indexed, such as an int
-- so if you have a list of integers, the game simply crashes anytime you call the function on it
function HangedMan.better_pseudoshuffle(list, seed)
    if not list then return nil end
    if seed then math.randomseed(pseudoseed(""..seed)) end

    for i = #list, 2, -1 do
        local j = math.random(i)
        list[i], list[j] = list[j], list[i]
    end
end

-- Get hand type of a Planet card
-- Yoinked straight off of from Aikoshen
-- thank you aiko reliable as always
function HangedMan.get_hand_in_game(_c)
    return (G.GAME and 
    G.GAME.hands and 
    _c.ability and 
    _c.ability.hand_type and 
    G.GAME.hands[_c.ability.hand_type]) 
    and G.GAME.hands[_c.ability.hand_type] or nil
end

-- Function to immediately kill a run
-- thank you Winter reliable as always
function HangedMan.instant_death()
    G.STATE = G.STATES.GAME_OVER
    if not G.GAME.won and not G.GAME.seeded and not G.GAME.challenge then
        G.PROFILES[G.SETTINGS.profile].high_scores.current_streak.amt = 0
    end
    G:save_settings()
    G.FILE_HANDLER.force = true
    G.STATE_COMPLETE = false
end


-- yahimouse helper function reference
function HangedMan.findOutIfThisNumberIsEvenInTheMostInefficientWayPossible(num)
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