SMODS.Blind {
    key = "theBloat",
    dollars = 5,
    mult = 2,
    atlas = 'HangedMan_BlindChips',
    pos = { x = 0, y = 0 },
    boss = { min = 1 },
    discovered = false,
    boss_colour = HEX("78beb7"),
    attributes = {'playing_card'},

    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.press_play then
            local cards = {}
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    for i = 1, #G.play.cards do
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.play.cards[i]:juice_up()
                                cards[#cards+1] = SMODS.add_card { set = "Base", key_append = "HangedMan_theBloat", no_edition = true }
                                cards[#cards+1] = SMODS.add_card { set = "Base", key_append = "HangedMan_theBloat", no_edition = true }
                                return true
                            end,
                        }))
                        SMODS.calculate_context({ playing_card_added = true, cards = cards })
                        delay(0.23)
                    end
                    
                    return true
                end
            }))
            blind.triggered = true
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
                            play_sound('tarot2', 0.76, 0.4)
                            return true
                        end
                    }))
                    play_sound('tarot2', 1, 0.4)
                    return true
                end)
            }))
            delay(0.4)

            
        end
    end
}