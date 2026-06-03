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

    end
}