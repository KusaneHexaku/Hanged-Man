SMODS.Blind {
    key = "theBank",
    dollars = 5,
    mult = 5,
    atlas = 'HangedMan_BlindChips',
    pos = { x = 0, y = 2 },
    boss = { min = 4 },
    discovered = false,
    boss_colour = HEX("ffc725"),
    debuff = {
        HangedMan_theBank_decrement = 0.5
    },
    attributes = {'large_blind'},

    loc_vars = function (self)
        return {
            vars = {
                math.max(0.5,(self.mult - (self.debuff.HangedMan_theBank_decrement * (G.GAME.HangedMan_shop_skipped or 0)))),
                self.debuff.HangedMan_theBank_decrement,
                self.debuff.HangedMan_theBank_decrement
            }
        }
    end,
    collection_loc_vars = function (self)
        return {
            vars = {
                self.mult,
                self.debuff.HangedMan_theBank_decrement,
                self.debuff.HangedMan_theBank_decrement
            }
        }
    end,
    disable = function (self)
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            func = function ()
                G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.ante) * 2 * G.GAME.starting_params.ante_scaling
                return true
            end
        }))
    end,
    set_blind = function (self)
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            func = function ()
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    func = function ()
                        G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.ante) * math.max(self.debuff.HangedMan_theBank_decrement,(self.mult - (self.debuff.HangedMan_theBank_decrement * (G.GAME.HangedMan_shop_skipped or 0)))) * G.GAME.starting_params.ante_scaling
                        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                        G.HUD_blind:get_UIE_by_ID("HUD_blind_count"):juice_up()
                        play_sound('timpani')
                        return true
                    end
                }))
                return true
            end
        }))
    end,

    calculate = function(self, blind, context)
        if blind.disabled then return end


    end
}