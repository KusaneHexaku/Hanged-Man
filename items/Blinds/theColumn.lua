SMODS.Blind {
    key = "theColumn",
    dollars = 5,
    mult = 2,
    atlas = 'HangedMan_BlindChips',
    pos = { x = 0, y = 4 },
    boss = { min = 3 },
    discovered = false,
    boss_colour = HEX("7a5010"),
    debuff = {
    },
    modifies_draw = true,
    attributes = {'debuff'},

    loc_vars = function (self)
        return {
            vars = {
                
            }
        }
    end,
    collection_loc_vars = function (self)
        return {
            vars = {
               
            }
        }
    end,
    disable = function (self)
       
    end,
    set_blind = function (self)
        
    end,

    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.debuff_card and context.debuff_card.area ~= G.jokers and
            context.debuff_card.ability.played_this_ante then
            return {
                debuff = true
            }
        end

        if context.hand_drawn then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local any_selected = nil
                    local _cards = {}
                    for _, playing_card in ipairs(G.hand.cards) do
                        if playing_card.ability.played_this_ante then
                            _cards[#_cards + 1] = playing_card
                            G.hand:add_to_highlighted(playing_card, true)
                            any_selected = true
                            play_sound('card1', 1)
                        end
                    end
                    if any_selected then
                        G.FUNCS.discard_cards_from_highlighted(nil, true)
                        blind.triggered = true
                    end
                    return true
                end
            }))
            delay(0.7)
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = (function()
                    SMODS.juice_up_blind()
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.06 * G.SETTINGS.GAMESPEED,
                        blockable = false,
                        blocking = false,
                        func = function()
                            play_sound('tarot2', 0.76, 0.4); return true
                        end
                    }))
                    play_sound('tarot2', 1, 0.4)
                    return true
                end)
            }))
            delay(0.4)
        end

    end,

}