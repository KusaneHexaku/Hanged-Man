SMODS.Blind {
    key = "final_wistfulWater",
    dollars = 8,
    mult = 2,
    atlas = 'HangedMan_ShowdownBlindChips',
    pos = { x = 0, y = 1 },
    boss = { showdown = true },
    discovered = false,
    boss_colour = HEX("c9a0dc"),
    debuff = {
        HangedMan_wistfulWater_mult = 2
    },
    attributes = {'discard'},

    loc_vars = function (self)
        return {
            vars = {
                self.debuff.HangedMan_wistfulWater_mult
            }
        }
    end,
    collection_loc_vars = function (self)
        return {
            vars = {
               self.debuff.HangedMan_wistfulWater_mult
            }
        }
    end,
    disable = function (self)
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            func = function ()
                G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.ante) * self.mult * G.GAME.starting_params.ante_scaling
                return true
            end
        }))
    end,
    set_blind = function (self)
        
    end,

    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.discard and context.other_card == context.full_hand[#context.full_hand] then
            G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    func = function ()
                        G.GAME.blind.chips = G.GAME.blind.chips * self.debuff.HangedMan_wistfulWater_mult
                        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                        G.HUD_blind:get_UIE_by_ID("HUD_blind_count"):juice_up()
                        play_sound('timpani')
                        return true
                    end
                }))
            blind.triggered = true
        end
    end,

}