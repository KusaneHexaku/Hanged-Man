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
            if current_money > 10 then
                -- Credits to Winter <3
                G.STATE = G.STATES.GAME_OVER
                if not G.GAME.won and not G.GAME.seeded and not G.GAME.challenge then
                    G.PROFILES[G.SETTINGS.profile].high_scores.current_streak.amt = 0
                end
                G:save_settings()
                G.FILE_HANDLER.force = true
                G.STATE_COMPLETE = false
            end
        end
        
        

    end
}