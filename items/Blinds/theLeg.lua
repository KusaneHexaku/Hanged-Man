SMODS.Blind {
    key = "theLeg",
    dollars = 5,
    mult = 2,
    atlas = 'HangedMan_BlindChips',
    pos = { x = 0, y = 5 },
    boss = { min = 1 },
    discovered = false,
    boss_colour = HEX("e9e941"),
    debuff = {
    },
    attributes = {'rank', 'chips'},

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

        if context.individual and context.cardarea == G.hand and not context.end_of_round and not SMODS.has_no_rank(context.other_card) then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            else
                local _c = context.other_card:get_id()*-1
                return {
                    chips = _c
                }
            end
        end
    end,

}