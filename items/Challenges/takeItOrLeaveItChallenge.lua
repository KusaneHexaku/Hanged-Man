SMODS.Challenge {
    key = 'takeItOrLeaveItChal',
    rules = {
        custom = {
            { id = 'one_of_each_shop' },
            { id = 'very_expensive_reroll' }
        },
    },
    restrictions = {
        banned_cards = {
            { id = 'j_chaos' },
        },
        banned_tags = 
        {
            { id = 'tag_d_six'}
        }
    },

    apply = function(self)
        change_shop_size(-1)
        SMODS.change_booster_limit(-1)
        G.GAME.round_resets.reroll_cost = 99
        G.GAME.current_round.reroll_cost = 99
        SMODS.change_free_rerolls(-99)

        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.round_resets.reroll_cost = 99
                G.GAME.current_round.reroll_cost = 99
                return true
            end
        }))

    end,

    calculate = function(self, context)

        if context.starting_shop then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.current_round.reroll_cost = G.GAME.round_resets.reroll_cost
                    SMODS.change_free_rerolls(-99)
                    return true
                end
            }))
        end
        
    end
}