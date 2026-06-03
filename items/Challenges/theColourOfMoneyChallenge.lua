SMODS.Challenge {
    key = 'theColourOfMoneyChal',
    rules = {
        custom = {
            { id = 'no_reward' },
            { id = 'no_extra_hand_money' },
            { id = 'no_interest' },
        },
        modifiers = {
            { id = 'dollars', value = 0 },
        }
    },
    jokers = {
        { id = 'j_hangedman_theColourOfMoney' },
        { id = 'j_hangedman_theColourOfMoney' },
        { id = 'j_hangedman_theColourOfMoney' },
        { id = 'j_hangedman_theColourOfMoney' },
        { id = 'j_hangedman_theColourOfMoney' },
    },
    restrictions = {
        banned_cards = {
            { id = 'v_seed_money' },
            { id = 'v_money_tree' },
            { id = 'j_to_the_moon' },
            { id = 'j_rocket' },
            { id = 'j_golden' },
            { id = 'j_satellite' },
            { id = 'j_egg' },
        }
    }
}