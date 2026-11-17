SMODS.Blind {
    key = "theFix",
    dollars = 5,
    mult = 2,
    atlas = 'HangedMan_BlindChips',
    pos = { x = 0, y = 7 },
    boss = { min = 3 },
    discovered = false,
    boss_colour = HEX("e94549"),
    debuff = {
        HangedMan_numerator_overwrite = 0
    },
    attributes = {'mod_chance'},

    loc_vars = function (self)
        return {
            vars = {
                self.debuff.HangedMan_numerator_overwrite
            }
        }
    end,
    collection_loc_vars = function (self)
        return {
            vars = {
               self.debuff.HangedMan_numerator_overwrite
            }
        }
    end,
    disable = function (self)
       
    end,
    set_blind = function (self)
        
    end,

    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.fix_probability and not blind.disabled then return { numerator = self.debuff.HangedMan_numerator_overwrite } end
      

    end,

}