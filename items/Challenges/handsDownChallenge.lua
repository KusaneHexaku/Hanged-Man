SMODS.Challenge {
    key = 'handsDownChal',
    rules = {
        custom = {
            { id = 'no_hands_reset'},
            { id = 'hands_down'},
            { id = 'no_extra_hand_money' },
        },
        modifiers = {
            { id = 'hands', value = 30 },
        }
    },
    restrictions = {
        banned_cards = {
            { id = 'j_burglar' },
            { id = 'j_troubadour'},
        }
    },

    apply = function(self)                
        G.GAME.hands_down_hand_remaining = 30
    end,

    calculate = function(self, context)

        G.GAME.round_resets.hands = G.GAME.hands_down_hand_remaining

        if context.main_scoring then
            G.GAME.hands_down_hand_remaining = G.GAME.hands_down_hand_remaining - 1
            
        end

        if context.starting_shop and context.main_eval and G.GAME.hands_down_hand_remaining < 1 then
            G.GAME.round_resets.hands = G.GAME.hands_down_hand_remaining
            ease_hands_played(-1)
        end

        if context.setting_blind and G.GAME.hands_down_hand_remaining < 1 then
            G.GAME.round_resets.hands = G.GAME.hands_down_hand_remaining
            ease_hands_played(-1)
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
}