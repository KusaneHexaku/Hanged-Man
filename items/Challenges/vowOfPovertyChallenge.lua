SMODS.Challenge {
    key = 'vowOfPovertyChal',
    rules = {
        custom = {
            { id = 'no_interest' },
            { id = 'vow_of_poverty'}
        },
        modifiers = {
            { id = 'dollars', value = 0 },
        }
    },
    restrictions = {
        banned_cards = {
            { id = 'j_credit_card' },
        }
    },

    calculate = function(self, context)

        if context.money_altered then
            local current_money = (G.GAME.dollars or 0)
            if current_money > 10 then HangedMan.instant_death() end
        end
        
    end
}