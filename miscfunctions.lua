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

-- Get the hand type of a Planet card from its key
-- probably not the correct way to do it but eh
function HangedMan.planet_hand_type_from_key(_key)
    if not _key then return nil end
    if not G.P_CENTER_POOLS.Planet then return nil end

    local _hand = nil

    for _, planet_center in pairs(G.P_CENTER_POOLS.Planet) do
        if planet_center.key == _key then
            if string.find(_key, 'c_akyrs_planet', 1, true) and (not string.find(_key, 'bishop_ring', 1, true)) then _hand = planet_center.akyrs_applicable_hands or nil
            elseif _key == 'c_akyrs_p_microscopium' then _hand = planet_center.config.akyrs_hand_types or nil
            else _hand = planet_center.config.hand_type end
            break
        end
    end

    return _hand
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

-- Function to display a `Nope!` on any card a la Wheel of Fortune failing
function HangedMan.display_wheel_nope(card)
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
            attention_text({
                text = localize('k_nope_ex'),
                scale = 1.3,
                hold = 1.4,
                major = card,
                backdrop_colour = G.C.SECONDARY_SET.Tarot,
                align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and 'tm' or 'cm',
                offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                silent = true
            })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.06 * G.SETTINGS.GAMESPEED,
                blockable = false,
                blocking = false,
                func = function()
                    play_sound('tarot2', 0.76, 0.4)
                    return true
                end
            }))
        play_sound('tarot2', 1, 0.4)
        card:juice_up(0.3, 0.5)
        return true
        end
    }))
end

-- function to remove all elements of a table
function HangedMan.emptyTable(table)
    if (not table) or (not type(table) == "table") then return end
    for k in pairs (table) do table[k] = nil end
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