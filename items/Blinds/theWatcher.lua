SMODS.Blind {
    key = "theWatcher",
    dollars = 5,
    mult = 2,
    atlas = 'HangedMan_BlindChips',
    pos = { x = 0, y = 3 },
    boss = { min = 3 },
    discovered = false,
    boss_colour = HEX("2d23eb"),
    debuff = {
    },
    attributes = {'hand_type'},

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

        if context.debuff_hand then
            if HangedMan.indexOf(G.GAME.HangedMan_unique_hands_this_ante, context.scoring_name) then
                blind.triggered = true
                return {debuff = true}
            end
        end

    end,

}