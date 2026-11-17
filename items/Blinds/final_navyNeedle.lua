SMODS.Blind {
    key = "final_navyNeedle",
    dollars = 8,
    mult = 2,
    atlas = 'HangedMan_ShowdownBlindChips',
    pos = { x = 0, y = 0 },
    boss = { showdown = true },
    discovered = false,
    boss_colour = HEX("0000aa"),
    debuff = {
    },
    attributes = {'hands'},

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
        if context.blind_disabled then
            ease_hands_played(blind.effect.hands_sub)
        end

        if blind.disabled then return end

        if context.setting_blind then
            blind.effect.hands_sub = G.GAME.round_resets.hands - 1
            ease_hands_played(-blind.effect.hands_sub)
        end
    end,

}